task :install do
  {
    "janus/janus/vim/vimrc" => "~/.vimrc",
    "vimrc"                 => "~/.vimrc.after",
    "vimrc"                 => "~/.vimrc.local",
    "bashrc"                => "~/.bashrc",
    "zshrc"                 => "~/.zshrc",
    "oh-my-zsh"             => "~/.oh-my-zsh",
    "tmux.conf"             => "~/.tmux.conf",
  }.each do |source, destination|
     `ln -s ~/.dotfiles/#{source} #{destination}`
  end
end
