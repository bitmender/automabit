#!/bin/bash


start() { 

	RUBY_VER="1.9.3"

		install_pkg "curl"
		install_pkg "git"
		install_rvm
		rvm_load_function
		rvm_install_ver 1.8.7	
		rvm_install_ver $RUBY_VER
		rvm_use_ver "$RUBY_VER@$HOSTNAME"
		gemrc_suppress_doc
		install_thor
		thor_create_example_task
		run_example_task
		thor_install_example_task
		thor_delete_example_task_file
}



install_pkg() { 
	echo "Installing package: $1"
		sudo apt-get install -y $1
}

install_rvm() {

	echo "Installing RVM"
		install_pkg "curl"
		bash -s stable < <(curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer )
		echo '[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function' >> ~/.bashrc
		install_pkg "build-essential openssl libreadline6 libreadline6-dev git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-0 libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion"

}

rvm_install_ver() { 
	echo "Installing RVM Ruby version: $1 "
		rvm install $1
}

rvm_use_ver() {
	echo "Setting up RVM gemset: $1"
		rvm use --install --create --default $1
}


rvm_load_function() {

	echo "Loading RVM into a shell session *as a function*"
		if [[ -s "$HOME/.rvm/scripts/rvm" ]] ; then

# First try to load from a user install
			source "$HOME/.rvm/scripts/rvm"

				elif [[ -s "/usr/local/rvm/scripts/rvm" ]] ; then

# Then try to load from a root install
				source "/usr/local/rvm/scripts/rvm"

		else

			printf "ERROR: An RVM installation was not found.\n"

				fi
}

gemrc_suppress_doc() {
	echo "Disabling rdoc/ri generation in ~/.gemrc"
		cat >> ~/.gemrc <<EOF
install: --no-rdoc --no-ri
update: --no-rdoc --no-ri
EOF
}

install_thor() {
	echo "Installing thor gem."
	gem install thor
}



thor_create_example_task() {
echo "Creatiing example speak thor file"
	cat >> test.thor <<EOF
class Test < Thor
  desc "example FILE", "an example task"
  method_option :delete, :aliases => "-d", :desc => "Delete the file after parsing it"
  def example(file)
    puts "You supplied the file: #{file}"
    delete_file = options[:delete]
    if delete_file
      puts "You specified that you would like to delete #{file}"
    else
      puts "You do not want to delete #{file}"
    end
  end
end
EOF
}


run_example_task() {

echo "Running example speak task"
thor test:example test.txt
}



thor_install_example_task() {
echo "Installing example task into system tasks (so you can run command from any dir)"
thor install test.thor

}


thor_delete_example_task_file() {
echo "Removing unneeded test.thor file created earlier."
rm test.thor
}

start

