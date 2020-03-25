FmtReset='\[$(tput sgr0)\]'
#FmtBold='\[\e[2m\]'

FgWhite='\[\e[38;5;255m\]'
FgRed='\[\e[38;5;197m\]'
FgBlue='\[\e[38;5;45m\]'
FgGreen='\[\e[38;5;40m\]'
FgPurple='\[\e[38;5;5m\]'
FgYellow='\[\e[38;5;226m\]'

PROMPT_COMMAND=__prompt_command

__prompt_command()
{
  RESULT=$?
  PS1=""

  # Exit status
  [[ $RESULT != 0 ]] && PS1+="${FgRed}$RESULT "

  # Shell
  PS1+="${FgYellow}"

  # Display if we're in tmux
  if [[ $TMUX ]]; then
    PS1+="tmux+"
  fi

  if [[ $IN_NIX_SHELL ]]; then
    PS1+="nix-shell"
  else
    PS1+='\s'
  fi

  # Scheme-authority separator
  PS1+="${FgWhite}://"

  # user
  PS1+="${FgGreen}\u"

  # @host
  PS1+="${FgWhite}@${FgPurple}\h"

  # /path
  IFS='/'
  read -ra SPLIT_PWD <<< $PWD
  for SEGMENT in "${SPLIT_PWD[@]}"; do
    [[ $SEGMENT ]] && PS1+="${FgWhite}/${FgBlue}${SEGMENT}"
  done
  IFS=' '

  # $ end
  PS1+="${FgRed} \$${FmtReset} "
}
