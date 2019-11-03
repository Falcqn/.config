
FmtReset='\[$(tput sgr0)\]'
#FmtBold='\[\e[2m\]'

FgWhite='\[\e[38;5;255m\]'
FgRed='\[\e[38;5;197m\]'
FgGreen='\[\e[38;5;40m\]'
FgBlue='\[\e[38;5;45m\]'
FgPurple='\[\e[38;5;5m\]'

PROMPT_COMMAND=__prompt_command

__prompt_command()
{
  local ExitStatus="$?"
  PS1=""

  # Exit status
  [[ $ExitStatus != 0 ]] && PS1+="${FgRed}${ExitStatus} "

  # user
  PS1+="${FgGreen}\u"

  # @host
  PS1+="${FgWhite}@${FgPurple}\h"

  # :directory
  PS1+="${FgWhite}:${FgBlue}\W"

  # $ end
  PS1+="${FgRed} \$${FmtReset} "
}
