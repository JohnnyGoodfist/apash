#!/usr/bin/env bash

# Dependencies #################################################################
apash.import fr.hastec.apash.util.Log

##/
# @name ShellUtils.isDeclared
# @brief Defensive programming technique to check that a variable is declared.
# @description
#   Arrays and Maps are considered as declared too.
#
# ## History
# @since 0.2.0 (hastec-fr)
#
# ## Interface
# @apashPackage
#
# ### Arguments
# | #      | varName        | Type          | in/out   | Default    | Description                           |
# |--------|----------------|---------------|----------|------------|---------------------------------------|
# | $1     | varName        | string        | in       |            | Variable name to check.               |
#
# ### Example
# ```bash
#    ShellUtils.isDeclared  ""              # false
#    ShellUtils.isDeclared  "myVar"         # false
#
#    myVar=myValue
#    ShellUtils.isDeclared  "myVar"         # true
#
#    declare -a myArray=()
#    ShellUtils.isDeclared  "myArray"       # true
#
#    declare -A myMap=([foo]=bar)
#    ShellUtils.isDeclared  "myMap"         # true
# ```
#
# @stdout None.
# @stderr None.
#
# @exitcode 0 When the variable is declared (even an array or a map).
# @exitcode 1 Otherwise.
#
# @see
# - [ShellUtils.isDeclared](./isDeclared.md), 
# - [ArrayUtils.isArray](../ArrayUtils/isArray.md),
# - [MapUtils.isMap](../MapUtils/isMap.md)
#/
ShellUtils.isDeclared() {
  Log.in $LINENO "$@"
  local varName="${1:-}"
  declare -p "$varName" > /dev/null 2>&1 || { Log.out $LINENO; return "$APASH_FAILURE"; }
  Log.out $LINENO; return "$APASH_SUCCESS"
}
