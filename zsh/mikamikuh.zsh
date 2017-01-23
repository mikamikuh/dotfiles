# Peco history selection
function peco-history-selection() {
  local tac
  if which tac > /dev/null; then
    tac="tac"
  else
    tac="tail -r"
  fi
  BUFFER=$(history -1 | eval $tac | cut -c 8- | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
}

zle -N peco-history-selection
bindkey '^R' peco-history-selection
