#!/usr/bin/env bash

# ---------
# ZSH Setup
# ---------

echo "Checking ZSH..."

if ! test -n $ZSH_VERSION; then
  echo "Install ZSH? (Y/n)"
  read confirm
  if [[ -z "$confirm" ]] || [[ "$confirm" =~ y|Y|yes ]]; then
    if type apt-get &>/dev/null; then
      sudo apt-get update
      sudo apt-get upgrade
      sudo apt-get install zsh
    elif type brew &>/dev/null; then
      brew install zsh
    fi
    sudo -s 'echo /usr/local/bin/zsh >> /etc/shells' && chsh -s /usr/local/bin/zsh
    zsh
  fi
fi

if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  echo "Install OhMyZSH? (Y/n)"
  read confirm

  if [[ -z "$confirm" ]] || [[ "$confirm" =~ y|Y|yes ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  fi
fi

echo "Installing dev dependencies"
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

sudo apt-get update

sudo apt-get install -y nodejs yarn gcc make zip unzip openjdk-8-jre openjdk-8jdk maven

# -------------
# Linking Files
# -------------

echo "Linking dotfiles..."

files_to_link=( ".bash_profile" ".zshrc" ".vimrc" ".zsh_functions" ".zsh_greeting" ".zsh_aliases" )

OLD_DOTS=".old_dotfiles"
if [[ -d "$HOME/$OLD_DOTS" ]]; then
  rm -rf "$HOME/$OLD_DOTS"
fi
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

echo "Configuring Git..."

echo -n "Git Name (e.g. John Smith): "
read ghubName
echo -n "Git Email: "
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

echo "Configuring Vim..."

if [[ ! -d "$HOME/.vim/bundle/Vundle.vim" ]]; then
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

vim +PluginInstall +qall

