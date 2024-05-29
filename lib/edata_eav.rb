require 'active_model_serializers'
require 'active_record'
require 'logger'
require 'dotenv'
Dotenv.load

# DB
require_relative 'edata_eav/configuration'
require_relative 'edata_eav/concerns/health_recordable'
require_relative 'edata_eav/concerns/uuid_generator'

module EdataEav
  class << self
    class Error < StandardError; end
    attr_accessor :logger

    def configure_logger
      @logger ||= Logger.new(STDOUT)
      @logger.level = Logger::DEBUG
      @logger.formatter = proc do |severity, datetime, progname, msg|
        "#{datetime.utc.iso8601} #{severity}: #{msg}\n"
      end
    end
  end

  def self.configuration
    @configuration ||= EdataEav::Configuration.new
  end

  def self.establish_connection
    configuration.establish_connection
  end

  configure_logger
end

# Models
require_relative 'edata_eav/base'
require_relative 'edata_eav/edata_pack'
require_relative 'edata_eav/edata_definition'
require_relative 'edata_eav/edata_value'
require_relative 'edata_eav/edata_migration_status'

# Serializers
require_relative 'edata_eav/serializers/edata_pack_serializer'
require_relative 'edata_eav/serializers/edata_value_serializer'
require_relative 'edata_eav/serializers/edata_definition_serializer'

# Utils
require_relative 'edata_eav/railtie' if defined?(Rails)
require_relative 'tasks' if defined?(Rake)

EdataEav.establish_connection
