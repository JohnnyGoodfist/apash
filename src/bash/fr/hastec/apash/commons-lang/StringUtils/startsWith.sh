#!/usr/bin/env bash

# File description ###########################################################
# @name StringUtils.startsWith
# @brief Check if a CharSequence starts with a specified prefix.
# @description <!-- -->
#
# ### Authors:
# * Benjamin VARGIN
#
# ### Parents
# <!-- apash.parentBegin -->
# [](../../../../.md) / [apash](../../../apash.md) / [commons-lang](../../commons-lang.md) / [StringUtils](../StringUtils.md) / 
# <!-- apash.parentEnd -->
#
# Method description #########################################################
# @description
# @example
#    if StringUtils.startsWith "" ""        ; then echo "true"; else echo "false"; # true
#    if StringUtils.startsWith "abcd" ""    ; then echo "true"; else echo "false"; # true
#    if StringUtils.startsWith "abcd" "ab"  ; then echo "true"; else echo "false"; # true
#    if StringUtils.startsWith "abcd" "abd" ; then echo "true"; else echo "false"; # false
#    if StringUtils.startsWith ""     "a"   ; then echo "true"; else echo "false"; # false
#
# @arg $1 string Input string to check
# @arg $2 the prefix to find
#
# @stdout None
# @stderr None
#
# @exitcode 0 If the string starts with the prefix
# @exitcode 1 Otherwise.
StringUtils.startsWith(){
  local inString=$1
  local inPrefix=$2

  [[ $inString =~ ^$inPrefix ]] && return "$APASH_FUNCTION_SUCCESS"
  return "$APASH_FUNCTION_FAILURE"
}