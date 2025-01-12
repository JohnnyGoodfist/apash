
<div align='center' id='apash-top'>
  <a href='https://github.com/hastec-fr/apash'>
    <img alt='apash-logo' src='../../../../../../assets/apash-logo.svg'/>
  </a>

  # Apash
</div>


# ShellUtils.isCommandValid
Determine if current APASH_SHELL is zsh.

## History
### Since
  * 0.2.0 (hastec-fr)

## Interface
### Package
<!-- apash.packageBegin -->
[apash](../../../apash.md) / [commons-lang](../../commons-lang.md) / [ShellUtils](../ShellUtils.md) / 
<!-- apash.packageEnd -->

### Arguments
 | #      | varName        | Type          | in/out   | Default    | Description                           |
 |--------|----------------|---------------|----------|------------|---------------------------------------|

### Example
 ```bash
    # From bash
    ShellUtils.isZsh  ""                # false

    # From zsh
    ShellUtils.isZsh  ""                # true
 ```

### Stdout
  * None.
### Stderr
  * None.

### Exit codes
  * **0**: When the command name is correct.
  * **1**: Otherwise.

  <div align='right'>[ <a href='#apash-top'>↑ Back to top ↑</a> ]</div>

