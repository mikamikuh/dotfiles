# Peco history selection
function peco-history-selection() {
  local tac
  if which tac > /dev/null; then
    tac="tac"
  else
    tac="tail -r"
  fi
  BUFFER=$(history -1000 | eval $tac | cut -c 8- | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
}

function ranger-cd {
    tempfile="$(mktemp -t tmp.XXXXXX)"
    ranger --choosedir="$tempfile" "${@:-$(pwd)}"
    test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
        cd -- "$(cat "$tempfile")"
    fi
    rm -f -- "$tempfile"
}

zle -N peco-history-selection

bindkey '^R' peco-history-selection
bindkey -s '^T' 'ranger-cd\n'

alias rc='ranger-cd'
setopt share_history

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

nvm use 14.17.0
pyenv global 3.9.4

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
