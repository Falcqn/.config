# Colours for ls and shorter 'list all'
alias ls='ls --color=auto'
alias ll='ls -larth'

# Colours for tree
[[ -x "$(command -v tree)" ]] && alias tree='tree -C'

# Bat is a prettier cat
[[ -x "$(command -v bat)" ]] && alias cat='bat'

# Pretty ping is a prettier ping
[[ -x $(command -v prettyping) ]] && alias ping='prettyping --nolegend --nounicode'

# TMUX
if [[ -x "$(command -v tmux)" ]]; then
  alias tmux='tmux -2'
  # export TERM if inside tmux
  [[ $TMUX != "" ]] && export TERM="screen-256color"
fi

# Edit todo file
alias todo='nvim ~/notes/todo.md'

# View files readonly
alias view='nvim -MR'
