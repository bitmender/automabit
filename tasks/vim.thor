class Vim < Thor
include Thor::Actions


desc "setup", "setup Vim with pathogen"
def setup

system "sudo apt-get install vim" 
["~/.vim" , "~/.vim/autoload", "~/.vim/bundle"].each do |directory|  empty_directory directory
system "curl -so ~/.vim/autoload/pathogen.vim https://raw.github.com/tpope/vim-pathogen/HEAD/autoload/pathogen.vim"

create_file "~/.vimrc" do
'
call pathogen#infect()
syntax on
filetype plugin indent on
'
end


end 
end

desc "add_rails_support", "Configure vim with rails support"
def add_rails_support
  add_bundle "git://github.com/tpope/vim-rails.git"
  add_bundle "https://github.com/scrooloose/nerdtree.git"
  add_bundle "git://github.com/tpope/vim-bundler.git"
  add_bundle "git://github.com/tpope/vim-rake.git"

end

desc "add_git_support", "Configure vim with fugitive support"
def add_git_support
   add_bundle "git://github.com/tpope/vim-fugitive.git"
end


desc "add_bundle LOCATION", "install a vim plugin gfrom given git location"
def add_bundle(location)
system "cd ~/.vim/bundle && git clone #{location}"
end



end


