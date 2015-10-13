require 'fileutils'
task :install do
  [

    ["~/.bashrc"        ,  "bashrc"],
    ["~/.gemrc"         ,  "gemrc"],
    ["~/.gitconfig"     ,  "gitconfig "],
    ["~/.janus"         ,  "janus-extensions"],
    ["~/.nvimrc"        ,  "vim/janus/vim/vimrc"],
    ["~/.oh-my-zsh"     ,  "oh-my-zsh"],
    ["~/.pystartup"     ,  "pystartup"],
    ["~/.pryrc"         ,  "pryrc"],
    ["~/.sshrc"         ,  "sshrc"],
    ["~/.sshrc.d"       ,  "sshrc.d"],
    ["~/.tmux.conf"     ,  "tmux.conf"],
    ["~/.vimrc"         ,  "vim/janus/vim/vimrc"],
    ["~/.vimrc.after"   ,  "vimrc"],
    ["~/.zprezto"       ,  "prezto"],
    ["~/.zshrc"         ,  "zshrc"],

  ].each do |destination, source|
    next if File.stat(File.expand_path(destination)) rescue nil
    next if File.symlink?(File.expand_path(destination))
    cmd = "ln -s ~/.dotfiles/#{source} #{destination}"
    puts cmd
    system cmd
  end
end

task :default => :install
