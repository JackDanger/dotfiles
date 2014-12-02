task :install do
  {
    "vim/janus/vim/vimrc"   => "~/.vimrc",
    "janus-extensions"      => "~/.janus",
    "vimrc"                 => "~/.vimrc.after",
    #"vimrc"                 => "~/.vimrc.local",
    "bashrc"                => "~/.bashrc",
    "zshrc"                 => "~/.zshrc",
    "oh-my-zsh"             => "~/.oh-my-zsh",
    "gitconfig"             => "~/.gitconfig",
    "tmux.conf"             => "~/.tmux.conf",
  }.each do |source, destination|
     `ln -s ~/.dotfiles/#{source} #{destination}`
  end
end
