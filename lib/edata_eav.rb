require 'active_record'
require 'logger'
require 'dotenv'
Dotenv.load

# Load configuration and logger setup
require_relative 'edata_eav/configuration'
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

# Load all models dynamically from 'edata_eav/models' directory
Dir[File.join(__dir__, 'edata_eav/models', '*.rb')].each { |file| require file }

# Serializers - Uncomment and modify as needed
# Dir[File.join(__dir__, 'edata_eav/serializers', '*.rb')].each { |file| require file }

# Rails-specific utilities
require_relative 'edata_eav/railtie' if defined?(Rails)
require_relative 'tasks' if defined?(Rake)

# Establish database connection
EdataEav.establish_connection
