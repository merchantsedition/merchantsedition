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

# All files we consider to be text files.
TEXTFILEQUOTES=('*.php')
TEXTFILEQUOTES+=('*.css')
TEXTFILEQUOTES+=('*.scss')
TEXTFILEQUOTES+=('*.sass')
TEXTFILEQUOTES+=('*.js')
TEXTFILEQUOTES+=('*.tpl')
TEXTFILEQUOTES+=('*.html')
TEXTFILEQUOTES+=('*.phtml')
TEXTFILEQUOTES+=('*.sh')
TEXTFILEQUOTES+=('*.sql')
TEXTFILEQUOTES+=('*.csv')
TEXTFILEQUOTES+=('*.json')
TEXTFILEQUOTES+=('*.xml')
TEXTFILEQUOTES+=('*.yml')
TEXTFILEQUOTES+=('*.txt')
TEXTFILEQUOTES+=('*.md')
TEXTFILEQUOTES+=('*.htaccess')
# Ignore vendor files. See also testignore{}.
IGNOREFILEQUOTES=(':^admin-dev/themes/default/css/vendor/')
IGNOREFILEQUOTES+=(':^admin-dev/themes/default/sass/vendor/')
IGNOREFILEQUOTES+=(':^admin-dev/themes/default/js/vendor/')
IGNOREFILEQUOTES+=(':^js/ace/')
IGNOREFILEQUOTES+=(':^js/cropper/')
IGNOREFILEQUOTES+=(':^js/jquery/')
IGNOREFILEQUOTES+=(':^js/tiny_mce/')
IGNOREFILEQUOTES+=(':^js/vendor/')
IGNOREFILEQUOTES+=(':^libs/')
IGNOREFILEQUOTES+=(':^views/js/libs/')
IGNOREFILEQUOTES+=(':^views/css/libs/')

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

  function git-grep {
    local F P=()
    while [ ${#} -ne 0 ] && [ "${1}" != '--' ]; do
      P+=("${1}")
      shift
    done
    shift
    for F in $(git grep "${P[@]}" ${GIT_MASTER} -- "${@}"); do
      echo "${F#${GIT_MASTER}:}"
    done
  }
  GREP='git-grep'

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
  GREP='grep'

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

# Compare content of files, e.g. index.php or code files, against two or three
# templates. Typically a template for a Merchant's Edition only version, a
# version for Merchant's Edition and thirty bees, as well as a version for all
# three, Merchant's Edition, thirty bees and PrestaShop combined.
#
# Parameters get accepted by variables:
#
#    COMPARE_1: Path of the template containing the first version.
#    COMPARE_2: Path of the template containing the second version.
#    COMPARE_3: Optional. Path of the template containing the third version.
# COMPARE_SKIP: Optional. Number of initial lines in the candidate file to
#               skip. Typically 1 for PHP files, 0 or unset for other languages.
# COMPARE_HINT: Optional. User hint on which part mismatches.
# COMPARE_LIST: Array with paths of files to compare.
#
# Parameters get unset after the operation.
function templatecompare {
  local VERSION_1 VERSION_2 VERSION_3 LEN_1 LEN_2 LEN_3 THIS_1 THIS_2 THIS_3
  local F DIFF_1 DIFF_2 DIFF_3

  # This is a kludge simplifying following code.
  if [ -z "${COMPARE_3}" ]; then
    COMPARE_3="${COMPARE_2}"
  fi

  VERSION_1=$(cat "${COMPARE_1}" | removecopyrightyears)
  VERSION_2=$(cat "${COMPARE_2}" | removecopyrightyears)
  VERSION_3=$(cat "${COMPARE_3}" | removecopyrightyears)

  LEN_1=$(wc -l < "${COMPARE_1}" | sed -e "s/\s*//g")
  LEN_2=$(wc -l < "${COMPARE_2}" | sed -e "s/\s*//g")
  LEN_3=$(wc -l < "${COMPARE_3}" | sed -e "s/\s*//g")

  COMPARE_SKIP=${COMPARE_SKIP:-0}
  let LEN_1=${LEN_1}+${COMPARE_SKIP}
  let LEN_2=${LEN_2}+${COMPARE_SKIP}
  let LEN_3=${LEN_3}+${COMPARE_SKIP}
  let COMPARE_SKIP=${COMPARE_SKIP}+1  # 'tail' does "start at line ...".

  COMPARE_HINT=${COMPARE_HINT:-''}
  [ "${COMPARE_HINT}" = "${COMPARE_HINT# }" ] && \
    COMPARE_HINT=" ${COMPARE_HINT}"

  for F in "${COMPARE_LIST[@]}"; do
    THIS_1=$(
      ${CAT} "${F}" \
      | head -${LEN_1} | tail -n+${COMPARE_SKIP} \
      | removecopyrightyears
    )
    THIS_2=$(
      ${CAT} "${F}" \
      | head -${LEN_2} | tail -n+${COMPARE_SKIP} \
      | removecopyrightyears
    )
    THIS_3=$(
      ${CAT} "${F}" \
      | head -${LEN_3} | tail -n+${COMPARE_SKIP} \
      | removecopyrightyears
    )
    if [ "${THIS_1}" != "${VERSION_1}" ] \
       && [ "${THIS_2}" != "${VERSION_2}" ] \
       && [ "${THIS_3}" != "${VERSION_3}" ]; then
      e "${F}${COMPARE_HINT} matches none of the templates."

      if [ ${OPTION_VERBOSE} = 'true' ]; then
        # Report shortest diff.
        DIFF_1=$(diff -u0 <(echo "${VERSION_1}") <(echo "${THIS_1}"))
        DIFF_2=$(diff -u0 <(echo "${VERSION_2}") <(echo "${THIS_2}"))
        DIFF_3=$(diff -u0 <(echo "${VERSION_3}") <(echo "${THIS_3}"))

        if [ ${#DIFF_1} -lt ${#DIFF_2} ] && [ ${#DIFF_1} -lt ${#DIFF_3} ]; then
          # Diff 1 is smallest.
          n "diff between ${F} (+) and ${COMPARE_1} (-):"
          u "$(tail -n+3 <(echo "${DIFF_1}"))"
        elif [ ${#DIFF_2} -lt ${#DIFF_3} ]; then
          # Diff 2 is smallest.
          n "diff between ${F} (+) and ${COMPARE_2} (-):"
          u "$(tail -n+3 <(echo "${DIFF_2}"))"
        else
          # Diff 3 is smallest.
          n "diff between ${F} (+) and ${COMPARE_3} (-):"
          u "$(tail -n+3 <(echo "${DIFF_3}"))"
        fi
      fi
    fi
  done
  unset COMPARE_1 COMPARE_2 COMPARE_3 COMPARE_SKIP COMPARE_HINT COMPARE_LIST
}

# Test wether we should skip this file from tests.
#
# Parameter 1: Path of the file in question, relative to repository root.
# Parameter 2: 'true' or default: print warnings about some files. To avoid
#              duplicate warnings about the same file.
#
#      Return: 0/true if the file should be skipped, 1/false otherwise.
function testignore {
  local SUFFIX WARN B F

  SUFFIX="${1##*.}"
  SUFFIX="${SUFFIX,,}"
  WARN=${2:-'true'}

  # Ignore vendor files not managed by Composer (and thus, committed to the
  # repository).
  [ "${1}" != "${1#admin-dev/filemanager/}" ] \
  && [ "${1}" = "${1%/index.php}" ] \
  && return 0;
  for F in "${IGNOREFILEQUOTES[@]}"; do
    F="${F:2}"
    [ "${1}" != "${1#${F}}" ] && return 0;
  done

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
  local TEXTFILES=("${TEXTFILEQUOTES[@]}" "${IGNOREFILEQUOTES[@]}")

  # Test against DOS line endings.
  for F in $(${GREP} -rl $'\r' -- "${TEXTFILES[@]}"); do
    e "file ${F} contains DOS/Windows line endings."
    FAULT='true'
  done

  # Test against trailing whitespace.
  for F in $(${GREP} -rl $'[ \t]$' -- "${TEXTFILES[@]}"); do
    testignore "${F}" && continue
    e "file ${F} contains trailing whitespace."
    FAULT='true'
  done

  # Test for a newline at end of file.
  for F in $(${GREP} -rlP '(?m)\N\z' -- "${TEXTFILES[@]}"); do
    testignore "${F}" && continue
    e "file ${F} misses a newline at end of file."
    FAULT='true'
  done

  if [ ${FAULT} = 'true' ]; then
    n "Most code editors have an option to remove trailing whitespace and"
    u "         add a newline at end of file on save automatically."
  fi
}

# Test for presence of various documentation files.
#
# No parameters, no return values.
function validate_documentation {
  local README

  # A README.md should exist.
  README=$(${FIND} . | grep -i '^readme.md$' | grep -v '^README.md$')
  if [ -z "${README}" ]; then
    README=$(${FIND} README.md)
    [ -z "${README}" ] \
    && e "file README.md missing."
  else
    # Wrong capitalization.
    e "file ${README} exists, but should be named 'README.md' (capitalization)."
  fi

  # A CONTRIBUTING.md can exist.
  README=$(${FIND} . | grep -i '^contributing.md$' | grep -v '^CONTRIBUTING.md$')
  if [ -n "${README}" ]; then
    # Wrong capitalization.
    e "file ${README} exists, but should be named 'CONTRIBUTING.md' (capitalization)."
  fi

  # Former documentation files should be absent.
  FILES=('readme')
  FILES+=('readme.txt')
  FILES+=('roadmap')
  FILES+=('roadmap.md')
  FILES+=('roadmap.txt')
  FILES+=('contributing')
  FILES+=('contributing.txt')

  FAULT='false'
  for F in "${FILES[@]}"; do
    UNWANTED=$(${FIND} . | grep -i '^'"${F}"'$')
    if [ -n "${UNWANTED}" ]; then
      e "file ${UNWANTED} shouldn't exist."
      FAULT='true'
    fi
  done
  [ ${FAULT} = 'true' ] && \
    n "content of such former documentation files goes into README.md now."
  unset FILES FAULT UNWANTED
}

# Test for presence of index.php files.
#
# No parameters, no return values.
function validate_indexphp {
  local DIRS D

  # This catches all directories, also creates tons of duplicates.
  DIRS=('.')
  for D in $(${FIND} .); do
    # These don't get packaged, see build.sh/buildmodule.sh.
    [ "${D::9}" = '.tbstore/' ] && continue
    [ "${D::6}" = 'tests/' ] && continue
    [ "${D::8}" = 'vagrant/' ] && continue
    # This one was intentionally removed.
    [ "${D::7}" = 'upload/' ] && continue

    while [ "${D}" != "${D%/*}" ]; do
      D="${D%/*}"
      DIRS+=("${D}")
    done
  done
  # Remove duplicates.
  DIRS=($(printf '%s\n' "${DIRS[@]}" | sort | uniq))

  for D in "${DIRS[@]}"; do
    ${FIND} "${D}/index.php" | grep -q '.' \
    || e "file index.php missing in ${D}/."
  done
}
