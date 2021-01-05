#!/usr/bin/env bash
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

function usage {
  echo "Usage: validatecore.sh [-h|--help] [-v|--verbose]"
  echo
  echo "This script runs a couple of plausibility and conformance tests on"
  echo "Merchant's Edition sources contained in the Git repository. Note that"
  echo "files checked into the repository get validated, not the ones on disk."
  echo
  echo "    -h, --help            Show this help and exit."
  echo
  echo "    -v, --verbose         Show (hopefully) helpful hints regarding the"
  echo "                          errors found, like diffs for file content"
  echo "                          mismatches and/or script snippets to fix such"
  echo "                          misalignments."
  echo
  echo "Example:"
  echo
  echo "  cd <repository root>"
  echo "  tools/validatecore.sh"
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

OPTION_VERBOSE='false'

while [ ${#} -ne 0 ]; do
  case "${1}" in
    '-h'|'--help')
      usage
      exit 0
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


### Preparations.

# We write into a report file to allow us to a) collect multiple findings and
# b) evaluate the collection before exiting.
REPORT=$(mktemp)
export REPORT

. "${0%/*}/validatecommon.sh"


### File maintenance.

validate_filepermissions

validate_whitespace


### Documentation files.

validate_documentation


### index.php files.

validate_indexphp


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
