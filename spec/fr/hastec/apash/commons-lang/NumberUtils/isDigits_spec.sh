Describe 'NumberUtils.isDigits'
  if [ "$APASH_TEST_MINIFIED" != "true" ]; then
    Include "$APASH_HOME_DIR/src/fr/hastec/apash.import"
    apash.import "fr.hastec.apash.commons-lang.NumberUtils.isDigits"
  else
    Include "$APASH_HOME_DIR/apash-${APASH_SHELL}-min.sh"
  fi
  APASH_LOG_LEVEL=$APASH_LOG_LEVEL_OFF

  It 'fails when the input number is empty'
    When call NumberUtils.isDigits 
    The output should equal ""
    The status should be failure
  End
  
  It 'fails when the input number is empty'
    When call NumberUtils.isDigits ""
    The output should equal ""
    The status should be failure
  End

  It 'fails when the string contains other char than digits'
    When call NumberUtils.isDigits " "
    The output should equal ""
    The status should be failure
  End

  It 'fails when the string contains other char than digits'
    When call NumberUtils.isDigits "-12"
    The output should equal ""
    The status should be failure
  End

  It 'fails when the string contains other char than digits'
    When call NumberUtils.isDigits "1.2"
    The output should equal ""
    The status should be failure
  End

  It 'fails when the string contains other char than digits'
    When call NumberUtils.isDigits "1e2"
    The output should equal ""
    The status should be failure
  End

  It 'fails when the string contains other char than digits'
    When call NumberUtils.isDigits " 12"
    The output should equal ""
    The status should be failure
  End

  It 'passes when the string contains only digits'
    When call NumberUtils.isDigits "123"
    The output should equal ""
    The status should be success
  End

  It 'passes when the string contains only digits'
    When call NumberUtils.isDigits "000"
    The output should equal ""
    The status should be success
  End

  It 'passes when the string contains only digits'
    When call NumberUtils.isDigits "1"
    The output should equal ""
    The status should be success
  End

End
