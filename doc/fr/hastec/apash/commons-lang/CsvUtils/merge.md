
<div align='center' id='apash-top'>
  <a href='https://github.com/hastec-fr/apash'>
    <img alt='apash-logo' src='../../../../../../assets/apash-logo.svg'/>
  </a>

  # Apash
</div>


# CsvUtils.merge
Merge two csv files according to their columns keys.
## Description
   ⚠️This is a utility feature not fully tested and not complete.
   It's currently used to generate compatibility matrix and requires
   more development to take delimiters (today only ",") and other use 
   cases into account.
   
## History
### Since
  * 0.2.0 (hastec-fr)

## Interface
### Package
<!-- apash.packageBegin -->
[apash](../../../apash.md) / [commons-lang](../../commons-lang.md) / [CsvUtils](../CsvUtils.md) / 
<!-- apash.packageEnd -->

### Arguments
 | #      | varName        | Type          | in/out   | Default    | Description                           |
 |--------|----------------|---------------|----------|------------|---------------------------------------|
 | $1     | inFile1        | string        | in       |            | The first csv file to merge.          |
 | $2     | inFile2        | string        | in       |            | The second csv file to merge          |

### Example
 ```bash
    CsvUtils.merge file1 file2  # Merge the csv files according to first column
 ```

### Stdout
  * The merge csv file.
### Stderr
  * None.

### Exit codes
  * **0**: When the result csv file is displayed.
  * **1**: Otherwise.

  <div align='right'>[ <a href='#apash-top'>↑ Back to top ↑</a> ]</div>

