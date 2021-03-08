#!/usr/bin/env bash
##
# Copyright (C) 2021 Merchant's Edition GbR
# Copyright (C) 2018 thirty bees
#
# NOTICE OF LICENSE
#
# This source file is subject to the Academic Free License (AFL 3.0)
# that is bundled with this package in the file LICENSE.md.
# It is also available through the world-wide-web at this URL:
# https://opensource.org/licenses/afl-3.0.php
# If you did not receive a copy of the license and are unable to
# obtain it through the world-wide-web, please send an email
# to contact@merchantsedition.com so we can send you a copy immediately.
#
# @author    Merchant's Edition <contact@merchantsedition.com>
# @author    thirty bees <modules@thirtybees.com>
# @copyright 2021 Merchant's Edition GbR
# @copyright 2018 thirty bees
# @license   Academic Free License (AFL 3.0)

function usage {
  echo "Usage: validatemodule.sh [-h|--help] [-r|--release] [-v|--verbose]"
  echo
  echo "This script runs a couple of plausibility and conformance tests on"
  echo "thirty bees modules contained in a Git repository. Note that files"
  echo "checked into the repository get validated, no the ones on disk."
  echo
  echo "    -h, --help            Show this help and exit."
  echo
  echo "    -r, --release         Run additional tests for making a release,"
  echo "                          like testing Git tags and versions declared."
  echo
  echo "    -v, --verbose         Show (hopefully) helpful hints regarding the"
  echo "                          errors found, like diffs for file content"
  echo "                          mismatches and/or script snippets to fix such"
  echo "                          misalignments."
  echo
  echo "Example to test a single module:"
  echo
  echo "  cd modules/bankwire"
  echo "  ../../tools/validatemodule.sh"
  echo
  echo "Example to test all submodules of the core repository:"
  echo
  echo "  git submodule foreach ../../tools/validatemodule.sh"
  echo
}


### Cleanup.
#
# Triggered by a trap to clean on unexpected exit as well.

function cleanup {
  if [ -n ${REPORT} ]; then
    rm -f ${REPORT}
  fi
}
trap cleanup 0


### Options parsing.

OPTION_RELEASE='false'
OPTION_VERBOSE='false'

while [ ${#} -ne 0 ]; do
  case "${1}" in
    '-h'|'--help')
      usage
      exit 0
      ;;
    '-r'|'--release')
      OPTION_RELEASE='true'
      ;;
    '-v'|'--verbose')
      OPTION_VERBOSE='true'
      ;;
    *)
      echo "Unknown option '${1}'. Try ${0} --help."
      exit 1
      ;;
  esac
  shift
done


### Auxilliary functions.

# More auxilliary functions come with validatecommon.sh included below.

# Extract a property of the module main class. More precisely, those properies
# which are set by '$this-><property>' in the constructor.
#
# Parameter 1: Property. E.g. 'bla' for getting what's set with '$this->bla'.
#
#      Return: Value of the requested property. Empty string if there is no
#              such entry.
function constructorentry {
  local MODULE_NAME

  MODULE_NAME=$(basename $(pwd))
  ${CAT} "${MODULE_NAME}".php | \
    sed -n '/__construct/,/^{    |\t}\}$/ {
      /\$this->'"${1}"'\s*=/ {
        # Extract strings in single quotes. Also ones in l()
        # and ones containing escaped single quotes.
        s/.*[ (]'"'"'\(.*\)'"'"'[);]*$/\1/
        /\$this->/ {
          # Above didnt match, not a string.
          s/.*\=\s*\(.*\);$/\1/
        }
        p
      }
    }'
}


### Preparations.

# We write into a report file to allow us to a) collect multiple findings and
# b) evaluate the collection before exiting.
REPORT=$(mktemp)
export REPORT

. "${0%/*}/validatecommon.sh"

# As Merchant's Edition has no direct influence on foreign modules, there isn't
# much we could validate.
if [ "$(constructorentry 'author')" != $'Merchant\\\'s Edition' ]; then
  echo "This is not a Merchant's Edition module. Skipping validation."

  exit 0
fi


### .gitignore

if [ ${IS_GIT} = 'true' ]; then
  if ${FIND} .gitignore | grep -q '.'; then
    # .gitignore should contain a minimum set of entries.
    ${CAT} .gitignore | grep -q '^/translations/\*$' || \
      e "line with '/translations/*' missing in .gitignore."
    ${CAT} .gitignore | grep -q '^!/translations/index\.php$' || \
      e "line with '!/translations/index.php' missing in .gitignore."
    ${CAT} .gitignore | grep -q '^/config\*\.xml$' || \
      e "line with 'config*.xml' missing in .gitignore."
    ${CAT} .gitignore | grep -q "^$(basename $(pwd))-\\*\\.zip$" || \
      e "line with '$(basename $(pwd))-*.zip' missing in .gitignore."
  else
    e "there is no .gitignore file."
  fi
fi


### File maintenance.

validate_filepermissions

validate_whitespace


### Translations stuff.
#
# Even modules not adding to the user interface have translations, e.g.
# name and description in the list of modules in backoffice.

# Note: 'grep -q .' is needed because Git commands always return success.
${FIND} translations/index.php | grep -q '.' || \
  e "file translations/index.php doesn't exist."
${FIND} translations/ | grep -vq '^translations/index\.php$' && \
  e "files other than index.php in translations/."


### Mail templates stuff.

if ${FIND} mails/ | grep -q '.'; then
  ${FIND} mails/index.php | grep -q '.' || \
    e "mails folder, but no file mails/index.php."
  ${FIND} mails/en/index.php | grep -q '.' || \
    e "mails folder, but no file mails/en/index.php."
  ${FIND} mails/ | grep -v '^mails/index\.php$' | grep -vq '^mails/en' && \
    e "mail templates other than english exist."
fi


### config.xml
#
# We insist on no such file to exist. These files get auto-generated. Trusting
# the auto-generated one means there can't be a content mismatch against the
# module's main class definitions.

${FIND} config.xml | grep -q '.' && \
  e "file config.xml exists."
${FIND} . | grep -q 'config_.*\.xml' && \
  e "at least one file config_<lang>.xml exists."


### Main class validity.

# Test wether mandatory constructor entries exist.
ENTRIES=('name')
ENTRIES+=('tab')
ENTRIES+=('version')
ENTRIES+=('author')
ENTRIES+=('need_instance')
ENTRIES+=('displayName')
ENTRIES+=('description')
ENTRIES+=('tb_versions_compliancy')
ENTRIES+=('tb_min_version')
FAULT='false'
for E in "${ENTRIES[@]}"; do
  if [ -z "$(constructorentry ${E})" ]; then
    e "mandatory PHP main class constructor entry '${E}' missing."
    FAULT='true'
  fi
done
# TODO: replace this lame text with a documentation link.
[ ${FAULT} = 'true' ] && \
  n "see PHP main class constructor, '\$this-><entry>'."
unset ENTRIES FAULT


### Absence of deprecated code.

# _PS_VERSION_ marks retrocompatibility code for PrestaShop. While core should
# keep such code for retrocompatibility with third party modules, modules them
# selfs have no such need.
${FIND} . | while read F; do
  ${CAT} "${F}" | grep -q '\b_PS_VERSION_\b' && \
    e "file ${F} contains '_PS_VERSION_'; PS retrocompatibility code is pointless."
done


### Capitalization.

validate_companyname

# Module name should be all uppercase, except for a few well known words.
NAME=$(constructorentry 'displayName')
FAULT='false'
for W in ${NAME}; do
  if [ ${#W} -gt 3 ] \
     && [ ${W} != 'thirty' ] \
     && [ ${W} != 'bees' ] \
     && [ ${W} != 'reCAPTCHA' ] \
     && [ ${W} != ${W^} ]; then
    e "'${W}' in module name should be uppercase."
    FAULT='true'
  fi
done
[ ${FAULT} = 'true' ] && \
  n "see PHP main class constructor, '\$this->displayName'."
unset NAME FAULT


### Documentation files.

validate_documentation

if ${FIND} README.md | grep -q '.'; then
  # These are needed as delimiters, so check for their presence early.
  HEADINGS=('Description')
  HEADINGS+=('License')
  HEADINGS+=('Roadmap')

  HEADING_MISSING='false'
  for H in "${HEADINGS[@]}"; do
    if ! ${CAT} README.md | grep -q "^## ${H}$"; then
      e "Heading '## ${H}' missing in README.md."
      HEADING_MISSING='true'
    fi
  done

  # First line of README.md should match 'displayName' main class property.
  CODE_NAME=$(constructorentry 'displayName')
  CODE_NAME="# ${CODE_NAME}"
  README_LINE=$(${CAT} README.md | sed -n '1 p')

  if [ "${CODE_NAME}" != "${README_LINE}" ]; then
    e "first line of README.md doesn't match 'displayName' main class property."
    n "by 'displayName': '${CODE_NAME}'"
    n "by     README.md: '${README_LINE}'"
  fi

  # Third line of README.md should match 'description' main class property.
  CODE_NAME=$(constructorentry 'description')
  README_LINE=$(${CAT} README.md | sed -n '3 p')

  if [ "${CODE_NAME}" != "${README_LINE}" ]; then
    e "third line of README.md doesn't match 'description' main class property."
    n "by 'description': '${CODE_NAME}'"
    n "by     README.md: '${README_LINE}'"
  fi

  if [ ${HEADING_MISSING} = 'false' ]; then
    # Sections 'License' up to 'Packaging' ( = stuff between '## License' and
    # '## Roadmap') should match the content of the README.md template for
    # modules.
    TEMPLATE_LINE=$(cat "${TEMPLATES_DIR}/README.md.module" | \
                      sed -n '/^## License$/, /^## Roadmap$/ {
                        /^## License$/ n
                        /^## Roadmap$/ ! p
                      }')
    README_LINE=$(${CAT} README.md | sed -n '/^## License$/, /^## Roadmap$/ {
                                               /^## License$/ n
                                               /^## Roadmap$/ ! p
                                             }')

    if [ "${TEMPLATE_LINE}" != "${README_LINE}" ]; then
      e "sections 'License' up to 'Packaging' in README.md don't match the template."
      n "diff between README.md (+) and ${TEMPLATES_DIR}/README.md.module (-):"
      u "$(diff -u0 <(echo "${TEMPLATE_LINE}") <(echo "${README_LINE}") | \
             tail -n+3)"
    fi
  fi

  # There should be a '#### Short Term' and a '#### Long Term' heading in
  # the Roadmap section.
  README_LINE=$(${CAT} README.md | \
                sed -n '/^## Roadmap$/,$ { /^#### Short Term$/ p }')
  [ -n "${README_LINE}" ] ||
    e "header '#### Short Term' missing in the 'Roadmap' section in README.md."
  README_LINE=$(${CAT} README.md | \
                sed -n '/^## Roadmap$/,$ { /^#### Long Term$/ p }')
  [ -n "${README_LINE}" ] ||
    e "header '#### Long Term' missing in the 'Roadmap' section in README.md."

  # Section 'Roadmap' should be at least 8 lines long.
  [ $(${CAT} README.md | sed -n '/^## Roadmap$/,$ p' | wc -l) -ge 8 ] || \
    e "section 'Roadmap' in README.md should be at least 8 lines long."

  unset HEADINGS HEADING_MISSING CODE_NAME README_LINE TEMPLATE_LINE
fi

# File LICENSE.md should exist and match the template.
if ${FIND} LICENSE.md | grep -q '.'; then
  TEMPLATE=$(cat "${TEMPLATES_DIR}/LICENSE.md.module")
  LICENSE=$(${CAT} LICENSE.md)

  if [ "${TEMPLATE}" != "${LICENSE}" ]; then
    e "content of LICENSE.md doesn't match the template."
    n "diff between LICENSE.md (+) and ${TEMPLATES_DIR}/LICENSE.md (-):"
    u "$(diff -u0 <(echo "${TEMPLATE}") <(echo "${LICENSE}") | tail -n+3)"
  fi
  unset TEMPLATE LICENSE
else
  e "file LICENSE.md doesn't exist."
  n "a template is in tools/templates/ in thirty bees core."
fi

# Alternative license file variations should be absent.
LICENSE=$(${FIND} . | grep -i '^license' | grep -v '^LICENSE.md$')
for F in ${LICENSE}; do
  e "file ${F} shouldn't exist."
  n "The license of this module goes into file LICENSE.md."
done
unset LICENSE


### Infrastructure files.

# thirty bees auxilliary files should be absent.
${FIND} .tbstore.yml | grep -q '.' \
&& e "file .tbstore.yml shouldn't exist."
${FIND} .tbstore/ | grep -q '.' \
&& e "directory .tbstore/ shouldn't exist."

# A build.sh should be absent.
if ${FIND} build.sh | grep -q '.'; then
  e "there is a file build.sh."
  n "building the module should be handled in buildmodule.sh in core."
  n "module specific adjustments go into buildfilter.sh in the module root."
fi

# Header of buildfilter.sh should match a template.
COMPARE_1="${TEMPLATES_DIR}/header.sh.me.module"
COMPARE_2="${TEMPLATES_DIR}/header.sh.metb.module"
COMPARE_3="${TEMPLATES_DIR}/header.sh.metbps.module"
COMPARE_SKIP=0
COMPARE_HINT=''
readarray -t COMPARE_LIST <<< $(${FIND} buildfilter.sh)
[ -z "${COMPARE_LIST[*]}" ] && COMPARE_LIST=()
templatecompare

# .htaccess files are deprecated. Don't work with Nginx.
FAULT='false'
for F in $(${FIND} . | grep '.htaccess'); do
  e "file ${F} shouldn't exist."
  FAULT='true'
done
[ ${FAULT} = 'true' ] && \
  n ".htaccess files ar not supported by Nginx and accordingly not safe."
unset FAULT


### index.php files.

validate_indexphp

# Each index.php should match either the version for thirty bees or the version
# for thirty bees and PrestaShop combined.
COMPARE_1="${TEMPLATES_DIR}/index.php.me.module"
COMPARE_2="${TEMPLATES_DIR}/index.php.metb.module"
COMPARE_3="${TEMPLATES_DIR}/index.php.metbps.module"
COMPARE_SKIP=0
COMPARE_HINT=''
COMPARE_LIST=($(${FIND} . | grep 'index\.php$'))
templatecompare


### Code file headers.
#
# Each code file's header is compared against the template for either thirty
# bees or thirty bees and PrestaShop combined and should match one of them.

# PHP and PHTML files.
COMPARE_1="${TEMPLATES_DIR}/header.php-js-css.tb.module"
COMPARE_2="${TEMPLATES_DIR}/header.php-js-css.tbps.module"
COMPARE_SKIP=1
COMPARE_HINT='header'
LIST=($(${FIND} . \
| grep -e '\.php$' \
       -e '\.phtml$' \
| grep -v '/index\.php$'
))
COMPARE_LIST=()
for F in "${LIST[@]}"; do
  testignore "${F}" && continue
  COMPARE_LIST+=("${F}")
done
unset LIST
templatecompare

# JS, CSS, Sass and SCSS files.
COMPARE_1="${TEMPLATES_DIR}/header.php-js-css.tb.module"
COMPARE_2="${TEMPLATES_DIR}/header.php-js-css.tbps.module"
COMPARE_SKIP=0
COMPARE_HINT='header'
LIST=($(${FIND} . \
| grep -e '\.js$' \
       -e '\.css$' \
       -e '\.sass$' \
       -e '\.scss$'
))
COMPARE_LIST=()
for F in "${LIST[@]}"; do
  testignore "${F}" && continue
  COMPARE_LIST+=("${F}")
done
unset LIST
templatecompare

# Smarty templates.
COMPARE_1="${TEMPLATES_DIR}/header.tpl.tb.module"
COMPARE_2="${TEMPLATES_DIR}/header.tpl.tbps.module"
COMPARE_SKIP=0
COMPARE_HINT='header'
COMPARE_LIST=($(${FIND} . | grep '\.tpl$'))
[ -z "${COMPARE_LIST[*]}" ] && COMPARE_LIST=()
templatecompare


### Copyright mentions.
#
# As time goes on, the years in copyright mentions have to get updated. Make
# sure this doesn't get forgotten.

validate_copyrightyear


### Repository and release related stuff.

if [ ${IS_GIT} = 'true' ] && [ ${OPTION_RELEASE} = 'true' ]; then
  # First, grab remote branches and tags. That's a real
  # remote operation, so let's cache the result.
  REMOTE=$(git remote -v | grep '[x/]thirtybees/' | head -1 | tr '\t' ' ')
  REMOTE="${REMOTE%% *}"
  [ -z "${REMOTE}" ] && REMOTE='origin'
  REMOTE_CACHE=$(git ls-remote --refs ${REMOTE})

  # Warn if there are remote branches besides 'master'.
  SURPLUS=$(sed '/\trefs\/heads/ !d
                 /\trefs\/heads\/master/ d
                 s/^[0-9a-f]*//
                 s/refs\/heads/   '${REMOTE}'/' <<< "${REMOTE_CACHE}"
            )
  if [ -n "${SURPLUS}" ]; then
    w "there are remote branches besides 'master'."
    n "These are:"
    u "${SURPLUS}"
  fi
  unset SURPLUS

  # Branch 'master' should be pushed and up to date.
  MASTER_LOCAL=$(git show -q master | head -1 | cut -d ' ' -f 2)
  MASTER_REMOTE=$(grep 'refs/heads/master' <<< "${REMOTE_CACHE}" | \
                    cut -d $'\t' -f 1)
  [ ${MASTER_LOCAL} = ${MASTER_REMOTE} ] || \
    w "branches 'master' and '${REMOTE}/master' don't match, a push is needed."
  unset MASTER_REMOTE

  # Latest tag should be a version tag.
  LATEST_NAME=$(git tag | tr -d 'v' | sort --reverse --version-sort | head -1)
  [ -n "$(git tag --list ${LATEST_NAME})" ] || \
    LATEST_NAME="v${LATEST_NAME}"  # Re-add the 'v'.
  [ -z "$(tr -d '.[:digit:]' <<< ${LATEST_NAME})" ] || \
    e "Git tag '${LATEST_NAME}' isn't a well formatted release tag."

  # Latest tag should match $this->version in the main class constructor.
  CODE_VERSION=$(constructorentry 'version')
  [ "${LATEST_NAME}" = "${CODE_VERSION}" ] || \
    e "latest tag '${LATEST_NAME}' should match \$this->version in the main class."
  unset CODE_VERSION

  # Latest tag should be pushed.
  grep -q $'\trefs/tags/'${LATEST_NAME} <<< "${REMOTE_CACHE}" || \
    w "latest tag '${LATEST_NAME}' not in the remote repository, needs a push."

  # All remote tags should exist locally.
  grep $'\trefs/tags/' <<< "${REMOTE_CACHE}" | while read T; do
    T=${T##*/}
    [ -n "$(git tag -l ${T})" ] || \
      e "remote tag ${T} doesn't exist locally."
  done

  # If there are significant changes between the latest tag ( = the latest
  # release) and current 'master', call for a release.
  #
  # Key is the definition of 'significant changes' here. For the time being, we
  # define this as a change to files going into the distribution package.

  LATEST_LOCAL=$(git show -q ${LATEST_NAME} | head -1 | cut -d ' ' -f 2)
  CHANGED_FILES=$(git diff --name-only ${LATEST_LOCAL}..${MASTER_LOCAL})

  # Get PATH_FILTER from buildmodule.sh.
  . "${TEMPLATES_DIR}/../buildmodule.sh" --filter-only master

  CHANGED_FILES=$(sed "${PATH_FILTER}" <<< "${CHANGED_FILES}")
  [ -z "${CHANGED_FILES}" ] || \
    e "significant changes since the last release, a new release is needed."
  unset MASTER_LOCAL LATEST_NAME CHANGED_FILES
  unset EXCLUDE_FILE EXCLUDE_DIR KEEP EXCLUDE_PATH PATH_FILTER

  # Latest tag ( = latest release) should be committed in the core repository,
  # if this module is a submodule there.
  THIS_REPO="${PWD}"
  CORE_REPO="$(cd "${TEMPLATES_DIR}/../.." && pwd)"
  CORE_REPO_COPY="${CORE_REPO}"
  while [ "${THIS_REPO:0:1}" = "${CORE_REPO_COPY:0:1}" ]; do
    THIS_REPO="${THIS_REPO:1}"
    CORE_REPO_COPY="${CORE_REPO_COPY:1}"
    [ -z "${THIS_REPO}" ] && break;
  done
  THIS_REPO="${THIS_REPO##/}"

  COMMIT_STATUS=$(cd "${CORE_REPO}" && \
                    git submodule status --cached "${THIS_REPO}" 2> /dev/null)
  if [ -n "${COMMIT_STATUS}" ]; then
    # This module is a submodule in core.
    COMMIT_STATUS="${COMMIT_STATUS:1}"
    COMMIT_STATUS="${COMMIT_STATUS%% *}"
    [ "${COMMIT_STATUS}" = "${LATEST_LOCAL}" ] || \
      e "module is submodule in core, but latest tag not committed there."
  fi
  unset LATEST_LOCAL THIS_REPO CORE_REPO CORE_REPO_COPY COMMIT_STATUS

  unset REMOTE REMOTE_CACHE
fi


### Evaluation of findings.

cat ${REPORT}

if grep -q '^  Error:' ${REPORT}; then
  if [ ${OPTION_VERBOSE} = 'true' ]; then
    echo
    echo "If these errors were introduced with your last commit, fix them,"
    echo "then use 'git commit --amend' to correct that last commit."
  else
    echo "Errors found. Use --verbose for additional hints."
  fi

  exit 1
else
  echo "Validation succeeded."
  exit 0
fi
