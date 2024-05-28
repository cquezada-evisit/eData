require 'yaml'
require 'erb'

module EdataEav
  class Configuration
    attr_accessor :database_configuration

    def initialize
      load_database_configuration
    end

    def load_database_configuration
      env = ENV['RACK_ENV'] || 'development'
      database_yml = File.join(__dir__, '..', '..', 'config', 'database.yml')
      erb = ERB.new(File.read(database_yml)).result
      config = YAML.safe_load(erb, aliases: true)[env]
      EdataEav.logger.info "DB Config: #{config.as_json}"
      self.database_configuration = config
    end

    def establish_connection
      ActiveRecord::Base.establish_connection(database_configuration)
    end
  end
end
