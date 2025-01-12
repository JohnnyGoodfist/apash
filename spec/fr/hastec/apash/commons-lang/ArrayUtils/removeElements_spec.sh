Describe 'ArrayUtils.removeElements'
  apash.import fr.hastec.apash.commons-lang.ArrayUtils.removeElements

  It 'fails when the input does not refer to an array'
    When call ArrayUtils.removeElements
    The output should equal ""
    The status should be failure
  End
  
  It 'fails when the input does not refer to an array'
    When call ArrayUtils.removeElements "" "a"
    The output should equal ""
    The status should be failure
  End

  It 'fails when the input does not refer to an array'
    When call ArrayUtils.removeElements " " "a"
    The output should equal ""
    The status should be failure
  End

  It 'fails when the input name refer to variable which is not an array'
    local myVar="aaaa"
    When call ArrayUtils.removeElements "myVar" "a"
    The output should equal ""
    The status should be failure
  End

  It 'fails when the input name refer to variable which is not an array'
    local -A myMap=(["foo"]="a" ["bar"]="a")
    When call ArrayUtils.removeElements "myMap" "a"
    The output should equal ""
    The status should be failure
  End
 
  It 'passes when the reference is an array'
    local myArray=("a" "b" "a" "c" "" "d")
    When call ArrayUtils.removeElements "myArray" "a"
    The output should equal ""
    The status should be success
    The value "${#myArray[@]}" should eq 5
    The variable 'myArray[APASH_ARRAY_FIRST_INDEX+0]' should eq "b"
    The variable 'myArray[APASH_ARRAY_FIRST_INDEX+1]' should eq "a"
    The variable 'myArray[APASH_ARRAY_FIRST_INDEX+2]' should eq "c"
    The variable 'myArray[APASH_ARRAY_FIRST_INDEX+3]' should eq ""
    The variable 'myArray[APASH_ARRAY_FIRST_INDEX+4]' should eq "d"
  End

  It 'passes when the reference is an array'
    local myArray=("b" "a" "c" "" "d")
    When call ArrayUtils.removeElements "myArray" "a"
    The output should equal ""
    The status should be success
    The value "${#myArray[@]}" should eq 4
    The variable 'myArray[APASH_ARRAY_FIRST_INDEX+0]' should eq "b"
    The variable 'myArray[APASH_ARRAY_FIRST_INDEX+1]' should eq "c"
    The variable 'myArray[APASH_ARRAY_FIRST_INDEX+2]' should eq ""
    The variable 'myArray[APASH_ARRAY_FIRST_INDEX+3]' should eq "d"
  End

  It 'passes when the reference is an array'
    local myArray=("b" "c" "" "d")
    When call ArrayUtils.removeElements "myArray" ""
    The output should equal ""
    The status should be success
    The value "${#myArray[@]}" should eq 3
    The variable 'myArray[APASH_ARRAY_FIRST_INDEX+0]' should eq "b"
    The variable 'myArray[APASH_ARRAY_FIRST_INDEX+1]' should eq "c"
    The variable 'myArray[APASH_ARRAY_FIRST_INDEX+2]' should eq "d"
  End

  It 'passes when the reference is an array'
    local myArray=("b" "c" "d")
    When call ArrayUtils.removeElements "myArray" "e"
    The output should equal ""
    The status should be success
    The value "${#myArray[@]}" should eq 3
    The variable 'myArray[APASH_ARRAY_FIRST_INDEX+0]' should eq "b"
    The variable 'myArray[APASH_ARRAY_FIRST_INDEX+1]' should eq "c"
    The variable 'myArray[APASH_ARRAY_FIRST_INDEX+2]' should eq "d"
  End

  It 'passes when the reference is an array'
    local myArray=("a" "b" "a" "c" "" "d")
    When call ArrayUtils.removeElements "myArray" "a" "a" "d"
    The output should equal ""
    The status should be success
    The value "${#myArray[@]}" should eq 3
    The variable 'myArray[APASH_ARRAY_FIRST_INDEX+0]' should eq "b"
    The variable 'myArray[APASH_ARRAY_FIRST_INDEX+1]' should eq "c"
    The variable 'myArray[APASH_ARRAY_FIRST_INDEX+2]' should eq ""
  End

  It 'passes when the reference is an array'
    local myArray=("a")
    When call ArrayUtils.removeElements "myArray" "a"
    The output should equal ""
    The status should be success
    The value "${#myArray[@]}" should eq 0
  End

  It 'passes when the reference is an array'
    local myArray=()
    When call ArrayUtils.removeElements "myArray" "a"
    The output should equal ""
    The status should be success
    The value "${#myArray[@]}" should eq 0
  End
End

