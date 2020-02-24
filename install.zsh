dotfiles=$(cd $(dirname $0) && pwd)
cd $dotfiles

# somewhat portable installer
system_install() {
  if which apt &>/dev/null; then
    sudo apt install -y $@
  elif which yum &>/dev/null; then
    sudo yum install -y $@
  elif [[ "Darwin" == "$(uname)" ]]; then
    brew install $@
  else
    >&2 echo "System not recognized: $(uname -a)"
    exit 1
  fi
}

system_install git
system_install thesilversearcher
system_install chruby
system_install ruby-install
system_install fzf

# Let's track most of our dotfiles in git
dotfilenames=(
bashrc
gemrc
gitconfig
gitignore
pystartup
pryrc
pypirc
sshrc
tmux.conf
vimrc
vimrc
zshrc
prezto
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

# Special ipython config location
mkdir -p ~/.ipython/profile_default
if [[ ! -f ~/.ipython/profile_default/ipython_config.py ]]; then
  ln -s $dotfiles/ipython_config.py     ~/.ipython/profile_default/ipython_config.py
fi

# Ensure we have the go version manager installed
if which gvm &>/dev/null; then
  true
else
  echo "Installing gvm (the go version manager)"
  bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
  echo 'source ~/.gvm/scripts/gvm' >> ~/.profile.local
  system_install golang
fi

if [[ "Darwin" == "$(uname)" ]]; then
  # Set up Apptivate config
  ln -s ~/Google\ Drive/configs/apptivate_hotkeys  ~/Library/Application\ Support/Apptivate/hotkeys
fi

# And install some just for Prezto
# for rcfile in $dotfiles/prezto/runcoms/z*; do
#   ln -s "$rcfile" "${rcfile:t}"
# done
