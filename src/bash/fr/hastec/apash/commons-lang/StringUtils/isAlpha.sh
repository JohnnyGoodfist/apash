#!/usr/bin/env bash

# File description ###########################################################
# @name StringUtils.isAlpha
# @brief Checks if the input string contains only Unicode letters.
# @description An empty string will return false.
# ### Authors:
# * Benjamin VARGIN

# Method description #########################################################
# @description
# ### Parents
# <!-- apash.parentBegin -->
# [](../../../../.md) / [apash](../../../apash.md) / [commons-lang](../../commons-lang.md) / [StringUtils](../StringUtils.md) / 
# <!-- apash.parentEnd -->
#
# @example
#    StringUtils.isAlpha ""            # false
#    StringUtils.isAlpha "     "       # false
#    StringUtils.isAlpha "abc"         # true
#    StringUtils.isAlpha "ab2c"        # false
#    StringUtils.isAlpha "ab-c"        # false
#    StringUtils.isAlpha "abéc"        # true
#
# @arg $1 string The string to evaluate
#
# @stdout None
# @stderr None
#
# @exitcode 0 If the input string contains only unicode letters
# @exitcode 1 contains other things than letters.
StringUtils.isAlpha() {
  [[ $1 =~ ^[[:alpha:]]+$ ]] && return "$APASH_FUNCTION_SUCCESS"
  return "$APASH_FUNCTION_FAILURE"
}
