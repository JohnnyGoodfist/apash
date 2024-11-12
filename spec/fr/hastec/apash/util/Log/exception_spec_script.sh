#!/usr/bin/env bash

if [ "$APASH_TEST_MINIFIED" != "true" ]; then
  [ "$APASH_SHELL" = "zsh" ] && . apash source
  apash.import "fr.hastec.apash.util.Log.exception"
else
  . $APASH_HOME_DIR/apash-$APASH_SHELL-min.sh
fi

myCaller(){ Log.exception 1 "myCaller-001" "InvalidNumber" ; }
myGrandCaller(){ myCaller; }

myGrandCaller
