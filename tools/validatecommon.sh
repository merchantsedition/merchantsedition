##
# Copyright (C) 2021 Merchant's Edition GbR
#
# NOTICE OF LICENSE
#
# This source file is subject to the Academic Free License (AFL 3.0)
# that is bundled with this package in the file LICENSE.md
# It is also available through the world-wide-web at this URL:
# http://opensource.org/licenses/afl-3.0.php
# If you did not receive a copy of the license and are unable to
# obtain it through the world-wide-web, please send an email
# to contact@merchantsedition.com so we can send you a copy immediately.
#
# @author    Merchant's Edition <contact@merchantsedition.com>
# @copyright 2021 Merchant's Edition GbR
# @license   Academic Free License (AFL 3.0)

### Command abstractions.

# Default values.
OPTION_RELEASE=${OPTION_RELEASE:-false}

if [ -e .git ]; then
  IS_GIT='true'

  # Find the branch to work on.
  if [ ${OPTION_RELEASE} = 'true' ]; then
    GIT_MASTER='master'

    # Test whether this branch actually exists.
    if ! git branch | grep -q '${GIT_MASTER}'; then
      echo "Error: there is no branch '${GIT_MASTER}', refusing to continue."
      # Exiting with 0 anyways to not stop 'git submodule foreach' runs.
      exit 0
    fi
  else
    # Use the current branch.
    GIT_MASTER=$(git rev-parse --abbrev-ref HEAD)

    # Bail out in a 'detached HEAD' situation.
    if [ ${GIT_MASTER} = 'HEAD' ]; then
      echo "Error: not on a Git branch tip, can't continue."
      # Exiting with 0 anyways to not stop 'git submodule foreach' runs.
      exit 0
    fi
  fi
  echo "Git repository detected. Looking at branch '${GIT_MASTER}'."

  # Abstract some commands to allow validating non-repositories as well.
  function git-cat {
    local F
    for F in "${@}"; do
      git show ${GIT_MASTER}:"${F}";
    done
  }
  CAT='git-cat'

  FIND="git ls-tree -r --name-only ${GIT_MASTER}"

  # Don't continue if there are staged changes.
  if [ $(git diff --staged | wc -l) -ne 0 ]; then
    echo "Error: there are uncommitted changes, can't continue."
    exit 1
  fi
else
  IS_GIT='false'
  echo "Not a Git repository. Validating bare file trees not tested. Aborting."

  CAT='cat'
  FIND='find'

  exit 1
fi

# Find directory with verification templates.
TEMPLATES_DIR="${0%/*}/templates"
if [ ! -r "${TEMPLATES_DIR}/README.md.module" ]; then
  echo "Verification templates directory should be ${TEMPLATES_DIR},"
  echo "but there is no file README.md.module inside it. Aborting."
  exit 1
fi


### Auxilliary functions.

# Report an error.
function e {
  echo "  Error: ${1}" >> ${REPORT}
}

# Report a warning.
function w {
  echo "Warning: ${1}" >> ${REPORT}
}

# Report a note.
function n {
  [ ${OPTION_VERBOSE} = 'true' ] && echo "   Note: ${1}" >> ${REPORT}
}

# Report unchanged.
function u {
  [ ${OPTION_VERBOSE} = 'true' ] && echo "${1}" >> ${REPORT}
}

# Remove copyright years in lines declaring a copyright. This makes file
# contents of different vintages comparable.
function removecopyrightyears {
  sed '/Copyright (C)/ s/ [0-9-]* //
       /@copyright/ s/ [0-9-]* //'
}

# Compare a list of files, e.g. index.phps or a code files, against two
# templates. Typically a template for a thirty bees only version and a version
# for thirty bees and PrestaShop combined.
#
# Parameters get accepted by variables:
#
#   COMPARE_TB: Path of the template containing the thirty bees only version.
# COMPARE_TBPS: Path of the template containing the combined version.
# COMPARE_SKIP: Optional. Number of initial lines in the candidate file to
#               skip. Typically 1 for PHP files, 0 or unset for other languages.
# COMPARE_HINT: Optional. User hint on which part mismatches.
# COMPARE_LIST: Array with paths of files to compare.
#
# Parameters get unset after the operation.
function templatecompare {
  local TB_VERSION TBPS_VERSION TB_LEN TBPS_LEN TB_THIS TBPS_THIS F

  TB_VERSION=$(cat "${COMPARE_TB}" | removecopyrightyears)
  TBPS_VERSION=$(cat "${COMPARE_TBPS}" | removecopyrightyears)
  TB_LEN=$(wc -l < "${COMPARE_TB}" | sed -e "s/\s*//g")
  TBPS_LEN=$(wc -l < "${COMPARE_TBPS}" | sed -e "s/\s*//g")

  COMPARE_SKIP=${COMPARE_SKIP:-0}
  let TB_LEN=${TB_LEN}+${COMPARE_SKIP}
  let TBPS_LEN=${TBPS_LEN}+${COMPARE_SKIP}
  let COMPARE_SKIP=${COMPARE_SKIP}+1  # 'tail' does "start at line ...".

  COMPARE_HINT=${COMPARE_HINT:-''}
  [ "${COMPARE_HINT}" = "${COMPARE_HINT# }" ] && \
    COMPARE_HINT=" ${COMPARE_HINT}"

  for F in "${COMPARE_LIST[@]}"; do
    TB_THIS=$(${CAT} "${F}" | \
                head -${TB_LEN} | tail -n+${COMPARE_SKIP} | \
                removecopyrightyears
              )
    TBPS_THIS=$(${CAT} "${F}" | \
                  head -${TBPS_LEN} | tail -n+${COMPARE_SKIP} | \
                  removecopyrightyears
                )
    if [ "${TB_THIS}" != "${TB_VERSION}" ] \
       && [ "${TBPS_THIS}" != "${TBPS_VERSION}" ]; then
      e "${F}${COMPARE_HINT} matches none of the templates."
      if grep -q 'PrestaShop SA' <<< "${TBPS_THIS}"; then
        # Should be a combined thirty bees / PS version.
        n "diff between ${F} (+) and ${COMPARE_TBPS} (-):"
        u "$(diff -u0 <(echo "${TBPS_VERSION}") <(echo "${TBPS_THIS}") | \
               tail -n+3)"
      else
        # thirty bees only version.
        n "diff between ${F} (+) and ${COMPARE_TB} (-):"
        u "$(diff -u0 <(echo "${TB_VERSION}") <(echo "${TB_THIS}") | \
               tail -n+3)"
      fi
    fi
  done
  unset COMPARE_TB COMPARE_TBPS COMPARE_SKIP COMPARE_HINT COMPARE_LIST
}

# Test wether we should skip this file from tests.
#
# Parameter 1: Path of the file in question, relative to repository root.
# Parameter 2: 'true' or default: print warnings about some files. To avoid
#              duplicate warnings about the same file.
#
#      Return: 0/true if the file should be skipped, 1/false otherwise.
function testignore {
  local SUFFIX WARN B

  SUFFIX="${1##*.}"
  SUFFIX="${SUFFIX,,}"
  WARN=${2:-'true'}

  # Ignore vendor files not managed by Composer (and thus, committed to the
  # repository). Those in libs/ match in some modules.
  # Except for PHP files this should match ignores in validate_whitespace{}.
  ( [ "${1}" != "${1#admin-dev/filemanager/}" ] \
    || [ "${1}" != "${1#js/ace/}" ] \
    || [ "${1}" != "${1#js/cropper/}" ] \
    || [ "${1}" != "${1#js/jquery/}" ] \
    || [ "${1}" != "${1#js/tiny_mce/}" ] \
    || [ "${1}" != "${1#js/vendor/}" ] \
    || [ "${1}" != "${1#libs/}" ] \
    || [ "${1}" != "${1#views/js/libs/}" ] \
    || [ "${1}" != "${1#views/css/libs/}" ] \
  ) && [ "${1}" = "${1%/index.php}" ] \
    && return 0;

  # Ignore empty CSS and JS files. They exist only to show developers
  # that such a file gets served, if not empty.
  ( [ ${SUFFIX} = 'js' ] || [ ${SUFFIX} = 'css' ] ) \
    && [ $(${CAT} "${1}" | wc -c) -eq 0 ] \
    && return 0

  # Ignore minimized files.
  [ "${1}" != "${1%.min.js}" ] \
    && return 0
  [ "${1}" != "${1%.min.css}" ] \
    && return 0

  # Skip most PHP classes in module tbupdater, which happen to be copies
  # of files in the core repository and as such, have an OSL license.
  # @todo: these exceptions should all go away.
  if [ ${SUFFIX} = 'php' ] \
     && [ "${PWD##*/}" = 'tbupdater' ] \
     && [ "${1%%/*}" = 'classes' ] \
     && ! ${CAT} "${1}" | grep -q '(AFL 3.0)'; then
    [ ${WARN} = 'true' ] && w "Skipping not AFL-licensed file ${1}."
    return 0
  fi

  # If the file contains a 'thirty bees' or a 'prestashop' it's most
  # likely one of our files.
  [ -n "$(${CAT} "${1}" | \
            sed -n 's/thirty bees/&/i p; s/prestashop/&/i p;')" ] \
    && return 1

  # Warn about and ignore not minimized vendor files.
  B="${1##*/}"
  if [ "${B}" != "${B#jquery.}" ] \
     || [ "${B}" != "${B#superfish}" ] \
     || [ "${B}" != "${B#hoverIntent}" ]; then
    [ ${WARN} = 'true' ] && w "vendor file ${1} should be minimized."
    return 0
  fi

  # Known, deprecated CSS exceptions.
  #
  # Module themeconfigurator, it's FontAwesome.
  if [ "${1}" = 'views/css/font/font.css' ]; then
    [ ${WARN} = 'true' ] && w "file ${1} should get moved into views/css/libs/."
    return 0
  fi

  return 1
}


### Common validation functions.

# Test for proper file permissions.
#
# No parameters, no return values.
function validate_filepermissions {
  local PERMS FILE L

  # None of the files should have executable permissions.
  if [ ${IS_GIT} = 'true' ]; then
    while read L; do
      PERMS="${L%% *}"
      PERMS="${PERMS:3:3}"
      FILE="${L##*$'\t'}"

      # Exclude shell scripts, they don't go into the release package anyways.
      [ "${FILE##*.}" = 'sh' ] && continue

      e "file ${FILE} has executable permissions (${PERMS})."
    done < <(git ls-tree -r ${GIT_MASTER} | grep -v -e '^100644' -e '^160000')
  else
    e "validating permissions not yet implemented for non-repositories."
  fi
}

# Test for appropriate whitespace.
#
# No parameters, no return values.
function validate_whitespace {
  local F
  local FAULT='false'

  # All files we consider to be text files.
  local TEXTFILES=('*.php')
  TEXTFILES+=('*.css')
  TEXTFILES+=('*.js')
  TEXTFILES+=('*.tpl')
  TEXTFILES+=('*.phtml')
  TEXTFILES+=('*.sh')
  TEXTFILES+=('*.xml')
  TEXTFILES+=('*.yml')
  TEXTFILES+=('*.md')
  # Ignore vendor files. See also testignore{}.
  TEXTFILES+=(':^js/ace/')
  TEXTFILES+=(':^js/cropper/')
  TEXTFILES+=(':^js/jquery/')
  TEXTFILES+=(':^js/tiny_mce/')
  TEXTFILES+=(':^js/vendor/')
  TEXTFILES+=(':^libs/')
  TEXTFILES+=(':^views/js/libs/')
  TEXTFILES+=(':^views/css/libs/')

  # Test against DOS line endings.
  for F in $(git grep -rl $'\r' ${GIT_MASTER} -- "${TEXTFILES[@]}"); do
    F="${F#${GIT_MASTER}:}"
    e "file ${F} contains DOS/Windows line endings."
    FAULT='true'
  done

  # Test against trailing whitespace.
  for F in $(git grep -rl $'[ \t]$' ${GIT_MASTER} -- "${TEXTFILES[@]}"); do
    F="${F#${GIT_MASTER}:}"
    testignore "${F}" && continue
    e "file ${F} contains trailing whitespace."
    FAULT='true'
  done

  # Test for a newline at end of file.
  for F in $(git grep -rlP '(?m)\N\z' ${GIT_MASTER} -- "${TEXTFILES[@]}"); do
    F="${F#${GIT_MASTER}:}"
    testignore "${F}" && continue
    e "file ${F} misses a newline at end of file."
    FAULT='true'
  done

  if [ ${FAULT} = 'true' ]; then
    n "Most code editors have an option to remove trailing whitespace and"
    u "         add a newline at end of file on save automatically."
  fi
}
