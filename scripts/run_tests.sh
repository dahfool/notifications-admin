#!/bin/bash
#
# Run project tests
#
# NOTE: This script expects to be run from the project root with
# ./scripts/run_tests.sh

# Use default environment vars for localhost if not already set

set -o pipefail

source environment_test.sh

function display_result {
  RESULT=$1
  EXIT_STATUS=$2
  TEST=$3

  if [ $RESULT -ne 0 ]; then
    echo -e "\033[31m$TEST failed\033[0m"
    exit $EXIT_STATUS
  else
    echo -e "\033[32m$TEST passed\033[0m"
  fi
}

pep8 .
display_result $? 1 "Code style check"

npm test
display_result $? 2 "Front end code style check"

export NOTIFY_ADMIN_ENVIRONMENT='config.Test'

## Code coverage
py.test -n2 --cov=app --cov-report=term-missing tests/
display_result $? 3 "Code coverage"
