task :install do
  [

    ["~/.bashrc"        ,  "bashrc"],
    ["~/.gemrc"         ,  "gemrc"],
    ["~/.gitconfig"     ,  "gitconfig "],
    ["~/.janus"         ,  "janus-extensions"],
    ["~/.nvimrc"        ,  "vim/janus/vim/vimrc"],
    ["~/.oh-my-zsh"     ,  "oh-my-zsh"],
    ["~/.pystartup"     ,  "pystartup"],
    ["~/.sshrc"         ,  "sshrc"],
    ["~/.sshrc.d"       ,  "sshrc.d"],
    ["~/.tmux.conf"     ,  "tmux.conf"],
    ["~/.vimrc"         ,  "vim/janus/vim/vimrc"],
    ["~/.vimrc.after"   ,  "vimrc"],
    ["~/.zprezto"       ,  "prezto"],
    ["~/.zshrc"         ,  "zshrc"],

  ].each do |destination, source|
     `ln -s ~/.dotfiles/#{source} #{destination}`
  end
end
