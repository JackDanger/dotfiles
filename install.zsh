dotfiles=$(cd $(dirname $0) && pwd)
pushd $dotfiles

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

if [[ "Darwin" == "$(uname)" ]]; then
  # Set up Apptivate config
  ln -s ~/Library/Application\ Support/Apptivate/hotkeys ~/Google\ Drive/configs/apptivate_hotkeys.bplist
fi

# And install some just for Prezto
# for rcfile in $dotfiles/prezto/runcoms/z*; do
#   ln -s "$rcfile" "${rcfile:t}"
# done
