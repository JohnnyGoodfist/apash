Describe 'ArrayUtils.addFirst'
  apash.import "fr.hastec.apash.commons-lang.ArrayUtils.addFirst"

  It 'fails when the input name does not refer to an array'
    When call ArrayUtils.addFirst 
    The output should equal ""
    The status should be failure
  End
  
  It 'fails when the input name does not refer to an array'
    When call ArrayUtils.addFirst ""
    The output should equal ""
    The status should be failure
  End

  It 'fails when the input name does not refer to an array'
    When call ArrayUtils.addFirst " "
    The output should equal ""
    The status should be failure
  End

  It 'fails when the input name does not refer to an array'
    local myVar="test"
    When call ArrayUtils.addFirst "myVar" "a"
    The output should equal ""
    The status should be failure
  End

  It 'fails when the input name does not refer to an array'
    local -A myMap=(["foo"]="bar")
    When call ArrayUtils.addFirst "myMap" "a"
    The output should equal ""
    The status should be failure
  End

  It 'fails when more than 1 value is provided'
    local myArray=("a" "b")
    When call ArrayUtils.addFirst "myArray" "c" "d"
    The output should equal ""
    The status should be failure
    The value "${#myArray[@]}" should eq 2
    The variable 'myArray[APASH_ARRAY_FIRST_INDEX+0]' should eq "a"
    The variable 'myArray[APASH_ARRAY_FIRST_INDEX+1]' should eq "b"
  End

  It 'passes and force array transformation'
    unset myArray
    When call ArrayUtils.addFirst "myArray" "a"
    The output should equal ""
    The status should be success
    The value "${#myArray[@]}" should eq 1
    The variable 'myArray[APASH_ARRAY_FIRST_INDEX+0]' should eq "a"
  End

  It 'passes when no value is provided'
    local myArray=()
    When call ArrayUtils.addFirst "myArray"
    The output should equal ""
    The status should be success
    The value "${#myArray[@]}" should eq 0
  End

  It 'passes when reference is an array and a value is declared'
    local myArray=()
    When call ArrayUtils.addFirst "myArray" "a"
    The output should equal ""
    The status should be success
    The value "${#myArray[@]}" should eq 1
    The variable 'myArray[APASH_ARRAY_FIRST_INDEX+0]' should eq "a"
  End

  It 'passes reference is an array and at least 1 one value is provided'
    local myArray=("a")
    When call ArrayUtils.addFirst "myArray" "foo bar"
    The output should equal ""
    The status should be success
    The value "${#myArray[@]}" should eq 2
    The variable 'myArray[APASH_ARRAY_FIRST_INDEX+0]' should eq "foo bar"
    The variable 'myArray[APASH_ARRAY_FIRST_INDEX+1]' should eq "a"
  End

  It 'passes reference is an array and at least 1 one value is provided'
    local myArray=("foo bar" "a")
    When call ArrayUtils.addFirst "myArray" ""
    The output should equal ""
    The status should be success
    The value "${#myArray[@]}" should eq 3
    The variable 'myArray[APASH_ARRAY_FIRST_INDEX+0]' should eq ""
    The variable 'myArray[APASH_ARRAY_FIRST_INDEX+1]' should eq "foo bar"
    The variable 'myArray[APASH_ARRAY_FIRST_INDEX+2]' should eq "a"
  End

  It 'passes reference is an array and indexes are not in sequence'
    local myArray=("foo bar" "a")
    myArray[APASH_ARRAY_FIRST_INDEX+4]="z"
    When call ArrayUtils.addFirst "myArray" ""
    The output should equal ""
    The status should be success
    The variable 'myArray[APASH_ARRAY_FIRST_INDEX+0]' should eq ""
    The variable 'myArray[APASH_ARRAY_FIRST_INDEX+1]' should eq "foo bar"
    The variable 'myArray[APASH_ARRAY_FIRST_INDEX+2]' should eq "a"
    The variable 'myArray[APASH_ARRAY_FIRST_INDEX+5]' should eq "z"
  End

End
