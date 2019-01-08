#!/usr/bin/env bash

# -------
# Initial
# -------

echo "Initial Installs/Upgrades..."

sudo apt-get update
sudo apt-get upgrade
sudo apt-get install -y curl vim git

# ---------
# ZSH Setup
# ---------

echo -e "\n\nChecking ZSH..."

if ! [ -x "$(command -v zsh)" ]; then
  echo "Install ZSH? (Y/n)"
  read zsh_confirm
  if [[ -z "$zsh_confirm" ]] || [[ "$zsh_confirm" =~ y|Y|yes ]]; then
    sudo apt-get install zsh
    sudo -s 'echo /usr/local/bin/zsh >> /etc/shells' && chsh -s $(which zsh)
  fi
fi


# ----------------
# Dev Dependencies
# ----------------

echo -e "\n\nInstalling dev dependencies..."

sudo apt-get update

curl -sL https://deb.nodesource.com/setup_11.x | sudo -E bash -
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
wget -O yarnpkg.gpg.pub https://dl.yarnpkg.com/debian/pubkey.gpg
gpg yarnpkg.gpg.pub #just check the expired date of the key
sudo apt-key add yarnpkg.gpg.pub

sudo apt-get install -y nodejs yarn gcc make zip unzip openjdk-8-jre openjdk-8-jdk maven python3 python3-venv python3-pip

yarn global add browser-sync

pip3 install neovim

# -------------
# Linking Files
# -------------

echo -e "\n\nLinking dotfiles..."

files_to_link=( ".bash_profile" ".zshrc" ".vimrc" ".zsh_functions" ".zsh_greeting" ".zsh_aliases" ".dircolors" ".gitignore_global" )

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

echo -e "\n\nConfiguring Git..."

echo -n "Git Name (e.g. John Smith): "
read gitName
echo -n "Git Email: "
read gitEmail

git config --global user.name "$gitName"
git config --global user.email "$gitEmail"

git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status

git config --global alias.unstage 'reset HEAD --'
git config --global alias.last 'log -1 HEAD'
git config --global alias.visual '!gitk'

git config --global core.excludesfile ~/.gitignore_global

# -----------------
# Vim Configuration
# -----------------

echo -e "\n\nConfiguring Vim..."

if [[ ! -d "$HOME/.vim/bundle/Vundle.vim" ]]; then
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

vim +PluginInstall +qall

# -----------
# Other Stuff
# -----------

echo -e "\n\nA few more things..."

if [[ ! -d "$HOME/Code" ]]; then
 mkdir "$HOME/Code"
fi


# -------
# Wrap Up
# -------

echo -e "\n\nWrapping up..."

if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  echo "Install OhMyZSH? (Y/n)"
  read omz_confirm

  if [[ -z "$omz_confirm" ]] || [[ "$omz_confirm" =~ y|Y|yes ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  fi
fi

if [[ -z "$zsh_confirm" ]] || [[ "$zsh_confirm" =~ y|Y|yes ]]; then
  zsh
fi

