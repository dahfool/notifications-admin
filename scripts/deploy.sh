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
STAGING_TAG="staging"
LIVE_TAG="live"

echo ""
echo "═════════════════════════════════════════════════════════════════════════════════════"
echo "Fetching from ${REMOTE}"
git fetch
echo "―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――"
echo -e  "${PURPLE}local    $(git log -n1 --oneline master)${RESTORE}"
echo -e "${LPURPLE}preview  $(git log -n1 --oneline origin/master)${RESTORE}"
echo -e   "${LBLUE}staging  $(git log -n1 --oneline origin/${STAGING_TAG})${RESTORE}"
echo -e  "${LGREEN}live     $(git log -n1 --oneline origin/${LIVE_TAG})${RESTORE}"
echo ""
echo "═════════════════════════════════════════════════════════════════════════════════════"
if [ "$1" == "" ]; then
    echo -e "${RED}No environment specified, try deploy.sh ${STAGING_TAG}${RESTORE}"
    exit 1
elif [ "$1" == "$STAGING_TAG" ]; then
    echo -e "Tagging ${LPURPLE}preview${RESTORE} for deployment to ${LBLUE}${STAGING_TAG}${RESTORE}"
    git tag -f $STAGING_TAG origin/master
elif [ "$1" == "$LIVE_TAG" ]; then
    echo -e "Tagging ${LBLUE}${STAGING_TAG}${RESTORE} for deployment to ${LGREEN}${LIVE_TAG}${RESTORE}"
    git tag -f $LIVE_TAG origin/staging
else
    echo -e "${RED}“$1” isn’t a something that can be deployed to${RESTORE}"
    exit 1
fi
echo "―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――"
echo "Done…"
echo ""
echo "═════════════════════════════════════════════════════════════════════════════════════"
if [ "$1" == "staging" ]; then
    echo -e "Pushing ${LBLUE}${STAGING_TAG}${RESTORE} tag to ${REMOTE}"
    echo "―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――"
    # git push origin $STAGING_TAG
elif [ "$1" == "live" ]; then
    echo -e "Pushing ${LGREEN}${LIVE_TAG}${RESTORE} tag to ${REMOTE}"
    echo "―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――"
    # git push origin $LIVE_TAG
fi
echo "Done"
