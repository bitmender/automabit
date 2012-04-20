class Vim < Thor
  namespace :vim
  include Thor::Actions

  def self.source_root
    File.dirname(__FILE__)
  end

  desc "setup", "install and setup vim to use pathogen"
  def setup

    invoke "system:install", ["vim"]
    ["~/.vim" , "~/.vim/autoload", "~/.vim/bundle"].each do |directory|  empty_directory directory
    system "curl -so ~/.vim/autoload/pathogen.vim https://raw.github.com/tpope/vim-pathogen/HEAD/autoload/pathogen.vim"
    end
  end

  desc "create_vimrc", "create ~/.vimrc with template"
  def create_vimrc
    template('templates/vimrc.erb', "~/.vimrc")
  end 

  desc "add_rails_support", "add rails.vim support"
  def add_rails_support
    add_bundle "git://github.com/tpope/vim-rails.git"
    add_bundle "https://github.com/scrooloose/nerdtree.git"
    add_bundle "git://github.com/tpope/vim-bundler.git"
    add_bundle "git://github.com/tpope/vim-rake.git"
  end

  desc "add_git_support", "add git fugitive support"
  def add_git_support
    add_bundle "git://github.com/tpope/vim-fugitive.git"
  end

  desc "add_bundle LOCATION", "install a vim plugin gfrom given git location"
  def add_bundle(location)
    system "cd ~/.vim/bundle && git clone #{location}"
  end
end
