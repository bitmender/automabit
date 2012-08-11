class Postgres < Thor
  namespace :postgres
  include Thor::Actions

  desc "setup", "install postgres, client, and devel lib"
  def setup
    #thor "system:install","postgresql postgresql-client libpq-dev"
    %w[postgresql postgresql-client libpq-dev].each do |package|
      thor "system:install", "#{package}"
    end
  end

  desc "create_user USERNAME", "create a database user"
  def create_user(username)
    system "sudo -u postgres createuser #{username}"
  end 
end





