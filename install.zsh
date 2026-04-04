dotfiles=$(cd $(dirname $0) && pwd)
cd $dotfiles

# somewhat portable installer
system_install() {
  if [[ "Darwin" == "$(uname)" ]]; then
    which brew || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    brew install $@
  elif which apt &>/dev/null; then
    sudo apt install -y $@
  elif which yum &>/dev/null; then
    sudo yum install -y $@
  else
    >&2 echo "System not recognized: $(uname -a)"
    exit 1
  fi
}

system_install git
system_install nvim
system_install the_silver_searcher
system_install fzf
system_install asdf
system_install uv

# Let's track most of our dotfiles in git
dotfilenames=(
bashrc
gitconfig
gitignore
jq
sshrc
tmux.conf
vimrc
vimrc
zshrc
)
for filename in $dotfilenames; do
  symlink=~/.${filename}

  if [[ -e ${symlink} ]]; then
    echo " - ${symlink} already exists"
  else
    echo " + creating ${symlink} -> $dotfiles/${filename}"
    ln -s $dotfiles/${filename} ~/.${filename}
  fi
done

# Neovim config
mkdir -p ~/.config
if [[ ! -e ~/.config/nvim ]]; then
  echo " + creating ~/.config/nvim -> $dotfiles/nvim"
  ln -s $dotfiles/nvim ~/.config/nvim
else
  echo " - ~/.config/nvim already exists"
fi

# Special ipython config location
mkdir -p ~/.ipython/profile_default
if [[ ! -f ~/.ipython/profile_default/ipython_config.py ]]; then
  ln -s $dotfiles/ipython_config.py     ~/.ipython/profile_default/ipython_config.py
fi

if [[ "Darwin" == "$(uname)" ]]; then
  # Set up Apptivate config
  ln -s ~/Google\ Drive/configs/apptivate_hotkeys  ~/Library/Application\ Support/Apptivate/hotkeys
fi

# And install some just for Prezto
# for rcfile in $dotfiles/prezto/runcoms/z*; do
#   ln -s "$rcfile" "${rcfile:t}"
# done
