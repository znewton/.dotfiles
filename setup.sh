#!/usr/bin/env bash

# -------------
# Linking Files
# -------------

files_to_link=( ".bash_profile" ".zshrc" ".vimrc" ".zsh_functions" ".zsh_greeting" ".zsh_aliases" )

OLD_DOTS=".old_dotfiles"
mkdir "$HOME/$OLD_DOTS"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

for filename in "${files_to_link[@]}"; do
  # if the file exists, archive it
  if [[ -e "$HOME/$filename" ]]; then
    mv "$HOME/$filename" "$OLD_DOTS/"
  fi
  # symlink new file
  if [[ -e "$DIR/$filename" ]]; then
    ln -sf "$DIR/$filename" "$HOME/$filename" 
  fi
done

# -----------------
# Git Configuration
# -----------------

echo -n "GitHub Name (e.g. John Smith): "
read ghubName
echo -n "GitHub Email: "
read ghubEmail

git config --global user.name "$ghubName"
git config --global user.email "$ghubEmail"

git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status

git config --global alias.unstage 'reset HEAD --'
git config --global alias.last 'log -1 HEAD'
git config --global alias.visual '!gitk'

# -----------------
# Vim Configuration
# -----------------



