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

  desc "Drop the database if it exists"
  task :drop_db do
    config = EdataEav.configuration.database_configuration
    ActiveRecord::Base.establish_connection(config.merge('database' => nil))
    existing_databases = ActiveRecord::Base.connection.execute("SHOW DATABASES LIKE '#{config['database']}'").to_a
    if existing_databases.any?
      puts "Dropping database #{config['database']}..."
      ActiveRecord::Base.connection.drop_database(config['database'])
      puts "Database #{config['database']} dropped"
    else
      puts "Database #{config['database']} does not exist"
    end
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
  task setup: [:drop_db, :create_db, :migrate]
end
