class Postgres < Thor
  namespace :postgres
  include Thor::Actions

  desc "setup", "install postgres, client, and devel lib"
  def setup
    invoke "system:install", [ %w{ postgressql posqgresql-client libpq-dev } ]
  end

  desc "create_user USERNAME", "create a database user"
  def create_user(username)
    system "sudo -u postgres createuser #{username}"
  end 
end





