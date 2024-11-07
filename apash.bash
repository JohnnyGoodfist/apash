#!/usr/bin/env bash
APASH_VERSION="0.2.0-snapshot"

##############################################################################
# @name apash.bash
# @brief Main script managing the script libraries.
# @description
#     apash is the entry point for executing action related to
#     the project. The following action are possible:
#     * doc:    Generate the documentation of Apash.
#
#     * init:   Initialize apash sourcing in startup script.
#
#     * source: Default action which source the main function 
#               allowing to import library scripts.
#
#     * test:   Launch the unitary test campaign.
#
#  Logic:
#    Apash parses the command line in three steps:
#       1. Parse the global arguments which should be applied on the command.
#       2. Parse the action to realize.
#       3. Parse the arguments of the action and execute it.
#    Once the command line is parsed, the action is executed (only one).
#   
#   The code is split in 4 levels to execute the logic:
#   0. executeApashCommand (Embedded main execution flow)
#     1.|-> parseApashCommandArgs
#     1.|-> executeApashAction
#         2.|-> executeApash<Action>
#             3.|-> parseApash<Action>Args
#             3.|-> Execute related subactions
#
#   This source is not essential thereafter, because the main concept is to
#   load other scripts as librairy ready to use (Source then forget).
#   
#   Note: POSIX operations as much as possible in this script.
#
# Command-line flags #########################################################
APASH_NB_ARGS=0                             # Number of argument before the action.
APASH_INIT_POST_INSTALL=false               # Init suboption.
APASH_SOURCE_ALL=${APASH_SOURCE_ALL:-false} # Source subtoption.

# Test suboption overriding options.
APASH_TEST_OPTIONS="--directory $APASH_HOME_DIR --shell $APASH_SHELL "

# Calculated flags
APASH_EXIT_REQUIRED=false        # Flag set to true when an issue occurs.

APASH_EXIT_REQUIRED=1
APASH_FUNCTION_SUCCESS=0

# Helps ######################################################################
showApashHelp(){
  cat << EOF
  Usage: ${0##*/} [-h|--help] [--version] ACTION [ACTION_ARGS]

  Apash command line wrapping actions for enabling features, generating
  documentation or executing tests.
  
      -h|--help|-?      display this help and exit.
      --version         display the current version of apash and exit.

  ACTIONS:
      doc               Generate documentations relative to apash.
                        Prerequisite: shdoc is avaiable.

      source            Source the apash root script for current shell.
                        Take care that this current script is sourced too.
      
      test              Execute the set of unitary tests.

  GETTING STARTED:
    First, source apash by using the source action or not passing any args:
        $ . apash       # Symbol "$" is the prompt and dot is important !
    
    Thereafter, libraries can be imported and used as following:
        $ apash.import fr.hastec.apash.commons-lang.StringUtils.indexOf
        $ StringUtils.indexOf "Gooood Morning" "M"
        # Result: 7
EOF
}

showApashDocHelp(){
  cat << EOF
  Usage: ${0##*/} doc [-h]

  Generate the documentation (in markdown format) based on the comments.
  
      -h|--help|-?      display this help and exit.

  PREREQUISITES: shdoc must be installed.
  Example:
  # Install basher
  $ curl -s \
    "https://raw.githubusercontent.com/basherpm/basher/master/install.sh" \
    | bash
  
  # Install shdoc
  $ basher install reconquest/shdoc

  # Open another terminal again to ensure that environment is well loaded.
EOF
}

showApashInitHelp(){
  cat << EOF
  Usage: ${0##*/} init [-h] [--post-install]

  Add necessary line to startup script for apash usage
  
      -h|--help|-?      display this help and exit.
      --post-install    Add necessary lines in startup script

  Example:
  $ apash init --post-install
  Lines added to the startup up script \$HOME/.bashrc with tag apashInstallTag   
  Open another terminal again to ensure that environment is well loaded.
EOF
}

showApashSourceHelp(){
  cat << EOF
  Usage: ${0##*/} source [-h]

  Source the main root script. It implies that it reset the list of 
  libraries already sourced.
  
      -h|--help|-?      display this help and exit.

EOF
}

showApashMinifyHelp(){
  cat << EOF
  Usage: ${0##*/} minify [-h]

  Minify all scripts into a single file ready to source.
  All apash.imports are removed.

      -h|--help|-?      display this help and exit.

EOF
}

showApashTestHelp(){
  cat << EOF
  Usage: ${0##*/} test [-h] [--test-options options] [--] [test paths]

  Execute unitary tests contained in the test directory.
  
      -h|--help|-?      display this help and exit.
      --test-options    options in a single argument for shellspec.
      --minified|-mn    Use minified version of apash.
      --compatibility   Launch the campaign of test to generate the
                        compatibility matrix.

  By default the shellspec command looks like:
  $ shellspec --shell bash spec/bash

  Example to override shellspec options:
  $ apash test --test-options "--shell bash --format tap" "\$APASH_HOME_DIR/spec"

  Example to select some tests:
  $ apash test \$APASH_HOME_DIR/spec/fr/hastec/apash/lang/Math/*.sh

  PREREQUISITES: shellspec must be installed.
  Example:
  $ curl -fsSL https://git.io/shellspec | sh -s -- --yes
  
  # Open another terminal again to ensure that environment is well loaded.
EOF
}

# LEVEL 0 - Embedded main execution flow #######################################
# @name executeApashCommand
# @description
#    Parse and Execute apash command.
#    Embedded main flow to prevent usage of exit statement
#    which quit the current session in case of sourcing.
executeApashCommand(){
  # If the current shell is not identified, then exit.
  if [ "$APASH_SHELL" != "bash" ] && [ "$APASH_SHELL" != "zsh" ]; then
    echo "Not supported shell for the moment." >&2
    return
  fi

  # Source main apash script if no argument has been passed.
  if [ $# -eq 0 ]; then
    # shellcheck disable=SC1091
    . "$APASH_HOME_DIR/src/bash/fr/hastec/apash.sh" && return
  fi

  parseApashCommandArgs "$@"
  shift "$APASH_NB_ARGS"
  [ "$APASH_EXIT_REQUIRED" = "true" ] && return

  executeApashAction "$@"
}

# LEVEL 1 - Apash main command ###############################################
# @name parseApashCommandArgs
# @brief Parse the main arguments of the command line.
# @see Technical way to parse: https://mywiki.wooledge.org/BashFAQ/035
parseApashCommandArgs(){
  while :; do
    # Check if the argument is still an option
    case $1 in
      "-"*) ;;
        *) break ;;
    esac

    case $1 in
      # Show helps
      -h|-\?|--help)
        show_help
        APASH_EXIT_REQUIRED=true && return        
        ;;

      # Show the version of the scipts
      --version)
        echo "$APASH_VERSION"
        APASH_EXIT_REQUIRED=true && return
        ;;

      # End of all options.
      --)             
        shift && APASH_NB_ARGS=$(( APASH_NB_ARGS + 1 ))
        break
        ;;

      # Display error message on unknown option
      -?*)
        printf 'WARN: Unknown option: %s\n' "$1" >&2
        APASH_EXIT_REQUIRED=true && return
        ;;

      # Stop parsing
      *)  # Default case: No more options, so break out of the loop.
        break
    esac
    shift && APASH_NB_ARGS=$(( APASH_NB_ARGS + 1 ))
  done
}

executeApashAction(){
  local action="$1"
  shift
  case "$action" in
    doc)
      executeApashDoc "$@"
      ;;

    init)
      executeApashInit "$@"
      ;;
    
    minify)
      executeApashMinify "$@"
      ;;

    source)
      executeApashSource "$@"
      ;;

    test)
      executeApashTest "$@"
      ;;

    -?*)
      printf 'WARN: Unknown action: %s\n' "$1" >&2
      APASH_EXIT_REQUIRED=true && return
      ;;
  esac
}


# LEVEL 2 - Actions ##########################################################
executeApashDoc(){
    parseApashDocArgs "$@" || return
    apash.import -f "fr/hastec/apash.doc"
    apash.doc
}

executeApashInit(){
  parseApashInitArgs "$@" || return
  [ $APASH_INIT_POST_INSTALL = "true" ] && executePostInstall
}

executeApashMinify(){
  parseApashMinifyArgs "$@" || return
  apash.import "fr/hastec/apash.minify"
  apash.minify
}

executeApashSource(){
  parseApashSourceArgs "$@" || return
    
  # shellcheck disable=SC1091
  . "$APASH_HOME_DIR/src/bash/fr/hastec/apash.sh"
  if [ "$APASH_SOURCE_ALL" = "true" ]; then
    while IFS= read -r -d '' file; do
      apash.import "$file"
    done < <(find "$APASH_HOME_DIR/src/bash" -name "*.sh" ! -name "apash.sh" ! -name "apashDoc.sh" -print0)
  fi
}

executeApashTest(){  
  APASH_NB_ARGS="0"
  parseApashTestArgs "$@" || return
  shift $APASH_NB_ARGS
  APASH_TEST_FILES=("$@")
  [ $# -eq 0 ] && APASH_TEST_FILES=("$APASH_HOME_DIR/spec/")
  
  # Split word intentionnaly the shellspec options.
  if [ "$APASH_TEST_MINIFIED" = "true" ]; then
    if [ "$APASH_SHELL" = "zsh" ]; then
      APASH_TEST_MINIFIED=true shellspec ${(z)APASH_TEST_OPTIONS} "${APASH_TEST_FILES[@]}"
    else
      # shellcheck disable=SC2086
      APASH_TEST_MINIFIED=true shellspec $APASH_TEST_OPTIONS "${APASH_TEST_FILES[@]}"
    fi
  else
    if [ "$APASH_SHELL" = "zsh" ]; then
      shellspec ${(z)APASH_TEST_OPTIONS} "${APASH_TEST_FILES[@]}"
    else
      # shellcheck disable=SC2086
      shellspec ${APASH_TEST_OPTIONS} "${APASH_TEST_FILES[@]}"
    fi
  fi
}

# LEVEL 3 - Parsing argument per action ########################################
parseApashInitArgs() {
  while :; do

    case $1 in
      # Show helps
      -h|-\?|--help)
        showApashInitHelp
        return $APASH_EXIT_REQUIRED
        ;;

      --post-install)
        APASH_INIT_POST_INSTALL=true
        ;;
      # End of all options.
      --)             
        shift
        break
        ;;

      # Display error message on unknown option
      -?*)
        printf 'WARN: Unknown option: %s\n' "$1" >&2
        return $APASH_EXIT_REQUIRED
        ;;

      # Stop parsing
      *)
        break
    esac
    shift
  done
  return $APASH_FUNCTION_SUCCESS
}

parseApashDocArgs() {
  while :; do

    case $1 in
      # Show helps
      -h|-\?|--help)
        showApashDocHelp
        return $APASH_EXIT_REQUIRED
        ;;

      # End of all options.
      --)             
        shift
        break
        ;;

      # Display error message on unknown option
      -?*)
        printf 'WARN: Unknown option: %s\n' "$1" >&2
        return $APASH_EXIT_REQUIRED
        ;;

      # Stop parsing
      *)
        break
    esac
    shift
  done
  return $APASH_FUNCTION_SUCCESS
}

parseApashMinifyArgs() {
  while :; do

    case $1 in
      # Show helps
      -h|-\?|--help)
        showApashMinifyHelp
        return $APASH_EXIT_REQUIRED
        ;;

      # End of all options.
      --)             
        shift
        break
        ;;

      # Display error message on unknown option
      -?*)
        printf 'WARN: Unknown option: %s\n' "$1" >&2
        return $APASH_EXIT_REQUIRED
        ;;

      # Stop parsing
      *)
        break
    esac
    shift
  done
  return $APASH_FUNCTION_SUCCESS
}

parseApashSourceArgs() {
  while :; do

    case $1 in
      # Show helps
      -h|-\?|--help)
        showApashSourceHelp
        return $APASH_EXIT_REQUIRED
        ;;

      -a|--all)
        APASH_SOURCE_ALL=true
        ;;

      # End of all options.
      --)             
        shift
        break
        ;;

      # Display error message on unknown option
      -?*)
        printf 'WARN: Unknown option: %s\n' "$1" >&2
        return $APASH_EXIT_REQUIRED
        ;;

      # Stop parsing
      *)
        break
    esac
    shift
  done
  return $APASH_FUNCTION_SUCCESS
}

parseApashTestArgs() {
  while :; do

    case $1 in
      # Show helps
      -h|-\?|--help)
        showApashTestHelp
        return $APASH_EXIT_REQUIRED
        ;;

      # Launch compatibility campaign
      --compatibility)
          apash.import -f "fr/hastec/apash.test.compatibility"
          apash.test.compatibility
          return $APASH_EXIT_REQUIRED
        ;;

      --test-options)
        if [ "$2" ]; then
          APASH_TEST_OPTIONS="$2"
          shift && APASH_NB_ARGS=$(( APASH_NB_ARGS + 1 ))
        fi
        ;;

      -mn|--minified)
        APASH_TEST_MINIFIED="true"
        ;;

      # End of all options.
      --)
        shift
        break
        ;;

      # Display error message on unknown option
      -?*)
        printf 'WARN: Unknown option: %s\n' "$1" >&2
        return $APASH_EXIT_REQUIRED
        ;;

      # Stop parsing
      *)
        break
    esac
    shift && APASH_NB_ARGS=$(( APASH_NB_ARGS + 1 ))
  done
  return $APASH_FUNCTION_SUCCESS
}

# LEVEL 3 - Sub action according to arguments ##################################
# @name executePostInstall
# @brief Add necessary instruction to startup script for apash usage.
executePostInstall(){  
  local startup_script=""
  local apash_keyword="apashInstallTag"
  case "$APASH_SHELL" in
    bash) startup_script="$HOME/.bashrc" ;;
    zsh)  startup_script="$HOME/.zshrc"  ;;
    *)    startup_script="" ;   ;;
  esac

  [ ! -w "$startup_script" ] && echo "Startup Script cannot be edited: $startup_script" >&2 && return

  if ! grep -q "$apash_keyword" "$startup_script" ; then
    (
      echo "export APASH_HOME_DIR=\"$APASH_HOME_DIR\"   ##$apash_keyword"
      echo "export PATH=\"\$PATH:\$APASH_HOME_DIR\"    ##$apash_keyword"
      echo ". \"\$APASH_HOME_DIR/apash\"              ##$apash_keyword"
    ) >> "$startup_script"
  else
    echo "The apash install tags are already present in $startup_script."
  fi
}

# MAIN FLOW ##################################################################
# Continue the main flow in a function to prevent usage of exit.
# If no argument, then execute directly the source action.
if [ $# -eq 0 ]; then
  executeApashSource
else
  # Zsh requires to re-declare functions when subprocesses are called.
  typeset -f "apash.import" > /dev/null || source "$APASH_HOME_DIR/src/bash/fr/hastec/apash.import"
  executeApashCommand "$@"
fi
