namespace :edata_eav do
  desc "Create the database if it doesn't exist"
  task :create_db do
    config = EdataEav.configuration.database_configuration
    begin
      ActiveRecord::Base.establish_connection(config)
      ActiveRecord::Base.connection
      puts "Database #{config['database']} already exists"
    rescue ActiveRecord::NoDatabaseError
      puts "Creating database #{config['database']}..."
      ActiveRecord::Base.establish_connection(config.merge('database' => nil))
      ActiveRecord::Base.connection.create_database(config['database'])
      puts "Database #{config['database']} created"
    end
  end

  desc "Drop the database"
  task :drop_db do
    config = EdataEav.configuration.database_configuration
    ActiveRecord::Base.establish_connection(config)
    puts "Dropping database #{config['database']}..."
    ActiveRecord::Base.connection.drop_database(config['database'])
    puts "Database #{config['database']} dropped"
  end

  desc "Run migrations if there are any pending"
  task :migrate do
    ActiveRecord::Base.establish_connection(EdataEav.configuration.database_configuration)
    migration_context = ActiveRecord::MigrationContext.new("db/migrate")
    if migration_context.needs_migration?
      puts "Running pending migrations..."
      migration_context.migrate
      puts "Migrations completed"
    else
      puts "No pending migrations"
    end
  end

  desc "Setup the database"
  task setup: [:create_db, :migrate]
end
