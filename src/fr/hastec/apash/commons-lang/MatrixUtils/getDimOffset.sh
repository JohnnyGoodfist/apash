#!/usr/bin/env bash

# Dependencies #####################################
apash.import fr.hastec.apash.commons-lang.MatrixUtils.isMatrix

# File description ###########################################################
# @name MatrixUtils.getDimOffsetOffset
# @brief Return the corresponding offset before to fall on the next cell of the same dimension.
#
# @description
#   ⚠️ It is an experimental function.
#   For a two dimensional array it return the length of a row.
#   For a cell, keep at least an offset of 1.
#
# ### Since:
# 0.2.0
#
# ### Authors:
# * Benjamin VARGIN
#
# ### Parents
# <!-- apash.parentBegin -->
# [](../../../../.md) / [apash](../../../apash.md) / [commons-lang](../../commons-lang.md) / [MatrixUtils](../MatrixUtils.md) / 
# <!-- apash.parentEnd -->

# Method description #########################################################
# @description
# #### Example
# ```bash
#    myMatrix=(1 2 3 4 5 6 7 8 9)
#    MatrixUtils.create myMatrix 3 3
#    MatrixUtils.getDimOffset "myMatrix" 0 1  # 1
#    MatrixUtils.getDimOffset "myMatrix" 0    # 3
#    MatrixUtils.getDimOffset "myMatrix" 1    # 3
#    MatrixUtils.getDimOffset "myMatrix"      # 9
# ```
#
# @arg $1 ref(string[]) Name of the matrix.
# @arg $2 number... The index per dimension.
#
# @stdout None.
# @stderr None.
#
# @exitcode 0 When the array is created.
# @exitcode 1 Otherwise.
MatrixUtils.getDimOffset() {
  [ $# -lt 1 ] && return "$APASH_FUNCTION_FAILURE"
  local matrixName="$1"
  shift
  local indexes=("$@")
  local dimOffset=0
  local -i i

  MatrixUtils.isMatrix "$matrixName" || return "$APASH_FUNCTION_FAILURE"
  local apash_dimMatrixName="${MatrixUtils_DIM_ARRAY_PREFIX}${matrixName}"

  # Initiliaze the first time with the first dimension then multiply it by the others.
  if [ "$APASH_SHELL" = "zsh" ]; then
    for ((i=${#indexes[@]}; i < ${#${(P)apash_dimMatrixName}[@]}; i++ )); do
      [[ $dimOffset -gt 0 ]] && dimOffset=$((dimOffset * ${${(P)apash_dimMatrixName}[APASH_ARRAY_FIRST_INDEX+i]})) || dimOffset=${${(P)apash_dimMatrixName}[APASH_ARRAY_FIRST_INDEX+i]}
    done
  else # bash
    local -n matrixDim="$apash_dimMatrixName"
    for ((i=${#indexes[@]}; i < ${#matrixDim[@]}; i++ )); do
      [[ $dimOffset -gt 0 ]] && dimOffset=$((dimOffset * matrixDim[i])) || dimOffset=${matrixDim[i]}
    done
  fi
  
  # Keep at least one cell.
  [ "$dimOffset" -le 0 ] && dimOffset=1

  echo "$dimOffset" && return "$APASH_FUNCTION_SUCCESS"
  return "$APASH_FUNCTION_FAILURE"
}
