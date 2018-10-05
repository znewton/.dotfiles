export ZSH="/home/znewton/.oh-my-zsh"

ZSH_THEME="agnoster"

CASE_SENSITIVE="true"

plugins=(
  git
)

source $ZSH/oh-my-zsh.sh


if [ -t 1 ]; then  
  cd ~
fi 

DEFAULT_USER=znewton
prompt_context(){}

files_to_source=( ".zsh_functions" ".zsh_aliases" ".zsh_greeting" )

for filename in "${files_to_source[@]}"; do
  if [[ -f "$HOME/$filename" ]]; then
    source "$HOME/$filename"
  fi
done

eval $( dircolors -b $HOME/.dircolors  )

alias glslbp='cd ~/glsl-boilerplate'

export PATH="$(yarn global bin):$PATH"
