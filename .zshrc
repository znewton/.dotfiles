export ZSH="/home/znewton/.oh-my-zsh"

ZSH_THEME="agnoster"

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
  if [ -f "$filename" ]; then
    source "$filename"
  fi
done

alias glslbp='cd ~/School/CS336/projects/glsl-boilerplate'
