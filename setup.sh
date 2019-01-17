#!/usr/bin/env bash

echo "Package manager: "
read pkg_mng
if ! [ -x "$(command -v "$pkg_mng")" ]; then
  echo "$pkg_mng command does not exist. Exiting..."
  exit
fi

# -------
# Initial
# -------

echo "Initial Installs/Upgrades..."

sudo $pkg_mng update
sudo $pkg_mng upgrade
sudo $pkg_mng install -y curl vim git

OLD_DOTS=".old_dotfiles"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

# ---------
# ZSH Setup
# ---------

echo -e "\n\nChecking ZSH..."

if ! [ -x "$(command -v zsh)" ]; then
  echo "Install ZSH? (Y/n)"
  read zsh_confirm
  if [[ -z "$zsh_confirm" ]] || [[ "$zsh_confirm" =~ y|Y|yes ]]; then
    sudo $pkg_mng install -y zsh fonts-powerline
    sudo -s 'echo /usr/local/bin/zsh >> /etc/shells' && chsh -s $(which zsh)
  fi
fi

if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  echo "Install OhMyZSH? (Y/n)"
  read omz_confirm

  if [[ -z "$omz_confirm" ]] || [[ "$omz_confirm" =~ y|Y|yes ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sed 's:env zsh -l::g' | sed 's:chsh -s .*$::g')"
  fi
fi


# ----------------
# Dev Dependencies
# ----------------

echo -e "\n\nInstalling dev dependencies..."

sudo $pkg_mng update

curl -sL https://deb.nodesource.com/setup_11.x | sudo -E bash -
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
wget -O yarnpkg.gpg.pub https://dl.yarnpkg.com/debian/pubkey.gpg
gpg yarnpkg.gpg.pub #just check the expired date of the key
sudo apt-key add yarnpkg.gpg.pub

sudo $pkg_mng install -y nodejs yarn gcc make zip unzip openjdk-8-jre openjdk-8-jdk maven python3 python3-venv python3-pip

yarn global add browser-sync

pip3 install neovim

# -------------
# Linking Files
# -------------

echo -e "\n\nLinking dotfiles..."

files_to_link=( ".bash_profile" ".zshrc" ".vimrc" ".zsh_functions" ".zsh_greeting" ".zsh_aliases" ".dircolors" ".gitignore_global" )

if [[ -d "$HOME/$OLD_DOTS" ]]; then
  rm -rf "$HOME/$OLD_DOTS"
fi
mkdir "$HOME/$OLD_DOTS"

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

if [[ ! -f "$HOME/.ssh/id_ecdsa.pub" ]]; then
  yes y |ssh-keygen -q -t ecdsa -N '' >/dev/null
fi
echo "Copy the following SSH key to your GitHub account (ENTER to continue):"
cat "$HOME/.ssh/id_ecdsa.pub"
read ENTER

# -----------------
# Vim Configuration
# -----------------

echo -e "\n\nConfiguring Vim..."

if [[ ! -d "$HOME/.vim/bundle/Vundle.vim" ]]; then
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

vim +PluginInstall +qall

# -------------------
# GNOME Configuration
# -------------------

if [echo "$XDG_CURRENT_DESKTOP" | grep -Eio 'gnome']; then
  echo -e "\n\nConfiguring GNOME..."
  sudo add-apt-repository -u -y ppa:snwh/ppa
  sudo $pkg_mng install -y arc-theme gnome-themes-standard gtk2-engines-murrine gnome-shell-extensions gnome-tweak-tool moka-icon-theme faba-icon-theme faba-mono-icons
  dconf load / < "$DIR/saved_settings.dconf"
fi


# -----------
# Other Stuff
# -----------

echo -e "\n\nA few more things..."

if [[ ! -d "$HOME/Code" ]]; then
 mkdir "$HOME/Code"
fi

if [ "$(ls -A "$HOME/Documents")" ]; then
  mv "$HOME/Documents" "$HOME/.old-Documents"
else
  git clone git@github.com:znewton/Documents "$HOME/Documents"
fi


# -------
# Wrap Up
# -------

echo -e "\n\nWrapping up..."

if [[ -z "$zsh_confirm" ]] || [[ "$zsh_confirm" =~ y|Y|yes ]]; then
  zsh
fi

