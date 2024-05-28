module EdataEav
  class Railtie < Rails::Railtie
    initializer "edata_eav.configure_rails_initialization" do
      Dotenv.load if defined?(Dotenv)

      EdataEav.configuration do |config|
        config.database_configuration = {
          adapter: ENV['EDATA_DB_ADAPTER'],
          host: ENV['EDATA_DB_HOST'],
          username: ENV['EDATA_DB_USERNAME'],
          password: ENV['EDATA_DB_PASSWORD'],
          database: ENV['EDATA_DB_DEVELOPMENT_DATABASE'],
          encoding: ENV['EDATA_DB_ENCODING'],
          pool: ENV['EDATA_DB_POOL'],
          port: ENV['EDATA_DB_PORT']
        }
      end

      EdataEav.establish_connection
    end
  end
end
