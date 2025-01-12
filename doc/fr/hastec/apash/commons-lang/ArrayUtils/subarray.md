
<div align='center' id='apash-top'>
  <a href='https://github.com/hastec-fr/apash'>
    <img alt='apash-logo' src='../../../../../../assets/apash-logo.svg'/>
  </a>

  # Apash
</div>


# ArrayUtils.subarray
Produces a new array containing the elements between the start and end indices.
## Description
   The start index is inclusive, the end index exclusive. 

## History
### Since
  * 0.1.0 (hastec-fr)

## Interface
### Package
<!-- apash.packageBegin -->
[apash](../../../apash.md) / [commons-lang](../../commons-lang.md) / [ArrayUtils](../ArrayUtils.md) / 
<!-- apash.packageEnd -->

### Arguments
 | #      | varName        | Type          | in/out   | Default         | Description                          |
 |--------|----------------|---------------|----------|-----------------|--------------------------------------|
 | $1     | apash_outSubArrayName| ref(string[]) | out      |                 | Name of the array to subarray.       |
 | $2     | apash_inArrayName    | ref(string[]) | in       |                 | Name of the original array.          |
 | $3     | apash_inStartIndex   | number        | in       |                 | The starting index. Undervalue (<0) is promoted to 0, overvalue (>array.length) results in an empty array.        |
 | $4     | apash_inEndIndex     | number        | in       |                 | The elements up to endIndex-1 are present in the returned subarray. Undervalue (< startIndex) produces empty array, overvalue (>array.length) is demoted to array. |

### Example
 ```bash
    myArray=("a" "b" "c" "d")
    ArrayUtils.subarray  "mySubArray"  "myArray"                 # failure - ""
    ArrayUtils.subarray  "mySubArray"  "myArray"  "0"            # failure - ""
    ArrayUtils.subarray  "mySubArray"  "myArray"  "0" "2"        # mySubArray=("a" "b" "c")

    myArray=("a" "b" "c" "d")
    ArrayUtils.subarray  "mySubArray"  "myArray"  "1" "2"        # mySubArray=("b" "c")

    myArray=("a" "b" "c" "d")
    ArrayUtils.subarray  "mySubArray"  "myArray"  "0" "2" "2"    # mySubArray=("c" "d" "a" "b")

    myArray=("a" "b" "c" "d")
    ArrayUtils.subarray  "mySubArray"  "myArray"  "0" "2" "0"    # mySubArray=("a" "b" "c" "d")

    myArray=("a" "b" "c" "d" "e")
    ArrayUtils.subarray  "mySubArray"  "myArray"  "0" "2" "2"    # mySubArray=("c" "d" "a" "b" "e")

    myArray=("a" "b" "c" "d" "e")
    ArrayUtils.subarray  "mySubArray"  "myArray"  "1" "3"  "3"   # mySubArray=("a" "d" "e" "b" "c")
 ```

### Stdout
  * None.
### Stderr
  * None.

### Exit codes
  * **0**: When the subarray is extracted.
  * **1**: When the input is not an array or the indexes are not integers.

### See also
  * https://commons.apache.org/proper/commons-lang/javadocs/api-release/src-html/org/apache/commons/lang3/ArrayUtils.html#line.8286

  <div align='right'>[ <a href='#apash-top'>↑ Back to top ↑</a> ]</div>

