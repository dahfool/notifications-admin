#!/bin/bash

RESTORE='\033[0m'

RED='\033[00;31m'
GREEN='\033[00;32m'
YELLOW='\033[00;33m'
BLUE='\033[00;34m'
PURPLE='\033[00;35m'
CYAN='\033[00;36m'
LIGHTGRAY='\033[00;37m'

LRED='\033[01;31m'
LGREEN='\033[01;32m'
LYELLOW='\033[01;33m'
LBLUE='\033[01;34m'
LPURPLE='\033[01;35m'
LCYAN='\033[01;36m'
WHITE='\033[01;37m'

REMOTE="$(git config --get remote.origin.url)"

echo ""
echo "═════════════════════════════════════════════════════════════════════════════════════"
echo "Fetching from ${REMOTE}"
git fetch
echo "―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――"
echo -e  "${PURPLE}local    $(git log -n1 --oneline master)${RESTORE}"
echo -e "${LPURPLE}preview  $(git log -n1 --oneline origin/master)${RESTORE}"
echo -e   "${LBLUE}staging  $(git log -n1 --oneline origin/staging)${RESTORE}"
echo -e  "${LGREEN}live     $(git log -n1 --oneline origin/live)${RESTORE}"
echo ""
echo "═════════════════════════════════════════════════════════════════════════════════════"
if [ "$1" == "staging" ]; then
    echo -e "Tagging ${LPURPLE}preview${RESTORE} for deployment to ${LBLUE}staging${RESTORE}"
    git tag -f staging origin/master
elif [ "$1" == "live" ]; then
    echo -e "Tagging ${LBLUE}staging${RESTORE} for deployment to ${LGREEN}live${RESTORE}"
    git tag -f live origin/staging
else
    echo -e "${RED}“$1” isn’t a something that can be deployed to${RESTORE}"
    exit 0
fi
echo "―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――"
echo "Done…"
echo ""
echo "═════════════════════════════════════════════════════════════════════════════════════"
if [ "$1" == "staging" ]; then
    echo -e "Pushing ${LBLUE}staging${RESTORE} tag to ${REMOTE}"
    echo "―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――"
    # git push origin staging
elif [ "$1" == "live" ]; then
    echo -e "Pushing ${LGREEN}live${RESTORE} tag to ${REMOTE}"
    echo "―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――"
    # git push origin live
fi
echo "Done"
