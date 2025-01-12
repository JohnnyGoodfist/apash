Describe 'Math.max'
  apash.import "fr.hastec.apash.lang.Math.max"

  It 'returns empty value when at least one input is not parsable'
    When call Math.max
    The output should equal ""
    The status should be failure
  End
  
  It 'returns empty value when at least one input is not parsable'
    When call Math.max ""
    The output should equal ""
    The status should be failure
  End

  It 'returns empty value when at least one input is not parsable'
    When call Math.max "a"
    The output should equal ""
    The status should be failure
  End

  It 'returns empty value when at least one input is not parsable'
    When call Math.max "0" "a"
    The output should equal ""
    The status should be failure
  End

  It 'returns the greater value of two numbers'
    When call Math.max "0" "1"
    The output should equal "1"
    The status should be success
  End

  It 'returns the greater value of two numbers'
    When call Math.max "2" "103"
    The output should equal "103"
    The status should be success
  End
  
  It 'returns the greater value of two numbers'
    When call Math.max "1" "-1"
    The output should equal "1"
    The status should be success
  End

  It 'returns the greater value of two numbers'
    When call Math.max "-2" "-3"
    The output should equal "-2"
    The status should be success
  End

  It 'returns the greater value of two numbers'
    When call Math.max "0.123" ".099"
    The output should equal "0.123"
    The status should be success
  End

  It 'returns the greater value of two numbers'
    When call Math.max ".123" "-0.123"
    The output should equal ".123"
    The status should be success
  End

  It 'returns the greater value of two numbers'
    When call Math.max "0.123" ".123"
    The output should equal "0.123"
    The status should be success
  End

  It 'returns the greater value of two numbers'
    When call Math.max "0" "000"
    The output should equal "0"
    The status should be success
  End

End
