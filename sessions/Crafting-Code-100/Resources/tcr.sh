#!/bin/bash

MSG_PAUSE_PERIOD_S=1
MIN_LOOP_PAUSE_PERIOD_S=5
SUCCESSFUL_LOOPS=0
REVERTS=0

if [ -z $1 ]; then
  LOOP_PAUSE_PERIOD_S=60
elif [ $1 -lt $MIN_LOOP_PAUSE_PERIOD_S ]; then
  LOOP_PAUSE_PERIOD_S=$MIN_LOOP_PAUSE_PERIOD_S
else
  LOOP_PAUSE_PERIOD_S=$1
fi

TIMESTAMP=$(date +%s)
BRANCH_NAME="tcr-$TIMESTAMP"
git co -b $BRANCH_NAME > /dev/null
clear
echo "--------------------------------------------------"
echo "welcome to test && commit || revert"
echo "--------------------------------------------------"
sleep $MSG_PAUSE_PERIOD_S
echo "take baby steps, commit working code, and keep those tests green!"
sleep $MSG_PAUSE_PERIOD_S
echo "if your tests aren't passing every $LOOP_PAUSE_PERIOD_S seconds, your code will be reverted!"
echo "working on new branch $BRANCH_NAME"


sleep $MSG_PAUSE_PERIOD_S
echo "ready..."
sleep $MSG_PAUSE_PERIOD_S
echo "set..."
sleep $MSG_PAUSE_PERIOD_S
echo "start coding!!!"

while true
do
  sleep `expr $LOOP_PAUSE_PERIOD_S - 3`
  echo ""
  echo "3..."
  sleep 1
  echo "2..."
  sleep 1
  echo "1..."
  sleep 1
  echo "testing..."

  TEST_OUTPUT=$(npm run test 2>&1)

#  echo "$TEST_OUTPUT"

  if [[ $TEST_OUTPUT == *"FAIL"* ||  $TEST_OUTPUT == *"fail"* ]]; then
    echo ""
    echo "uh oh, failing tests; bye bye code!"
    git clean -fd > /dev/null
    git reset --hard > /dev/null

    REVERTS=$((REVERTS + 1))

    echo ""
    echo "you managed $SUCCESSFUL_LOOPS successful iterations"

    SUCCESSFUL_LOOPS=0
  else
    echo ""
    echo "tests are green; committing!"

    SUCCESSFUL_LOOPS=$((SUCCESSFUL_LOOPS + 1))

    git add .
    git commit -m "all green; commit! $SUCCESSFUL_LOOPS" > /dev/null
  fi
done
