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
  PS1=""

  # Exit status
  [[ $? != 0 ]] && PS1+="${FgRed}$? "

  # Shell
  PS1+="${FgYellow}"
  local ShellLevel="$SHLVL"

  # Display if we're in tmux
  if [[ $TMUX ]]; then
    PS1+="tmux."
    let ShellLevel--
  fi

  if [[ $IN_NIX_SHELL ]]; then
    PS1+="nix-shell."
    let ShellLevel--
  fi

  PS1+='\s'

  # Display shell level
  [[ $ShellLevel > 1 ]] && PS1+=".${ShellLevel}"

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
