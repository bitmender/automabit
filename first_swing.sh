#!/bin/bash


start() { 

	RUBY_VER="ruby"

	install_pkg "curl"
	install_pkg "git"
	install_rvm
	rvm_load_function
	rvm_install_ver $RUBY_VER
	rvm_use_ver "$RUBY_VER@$HOSTNAME"
	gemrc_suppress_doc
	install_thor
	explain_next_steps
}



install_pkg() { 
	echo "Installing package: $1"
	sudo apt-get install -y $1
}

install_rvm() {

	echo "Installing RVM"
	install_pkg "curl"
	curl -L https://get.rvm.io | bash -s stable

	cat ~/.bash_login >> ~/.profile
	rm ~/.bash_login

	install_pkg "build-essential openssl libreadline6 libreadline6-dev git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-0 libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion"

}

rvm_load_function() {
	\# Load RVM into a shell session *as a function*
	if [[ -s "$HOME/.rvm/scripts/rvm" ]] ; then

		\# First try to load from a user install
		source "$HOME/.rvm/scripts/rvm"

	elif [[ -s "/usr/local/rvm/scripts/rvm" ]] ; then

		\# Then try to load from a root install
		source "/usr/local/rvm/scripts/rvm"

	else

		printf "ERROR: An RVM installation was not found.\n"

	fi
}


rvm_install_ver() { 
	echo "Installing RVM Ruby version: $1 "
	rvm install $1
}

rvm_use_ver() {
	echo "Setting up RVM gemset: $1"
	source ~/.profile
	rvm use --install --create --default $1
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

explain_next_steps() {
	echo "Bootstrap is complete."
	echo "To install automabit's thor files:"
	echo "git clone https://github.com/bitmender/automabit.git"
	echo "cd automabit/tasks"
	echo "thor install <taskname>.thor"
	echo ""
	echo "Otherwise, just start creating/importing your own thor files."
}

start

