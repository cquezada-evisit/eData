require 'active_record'
require 'dotenv'
require_relative 'edata_eav/configuration'
require_relative 'edata_eav/concerns/uuid_generator'
require_relative 'edata_eav/edata_pack'
require_relative 'edata_eav/edata_definition'
require_relative 'edata_eav/edata_value'

Dotenv.load

module EdataEav
  class Error < StandardError; end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.establish_connection
    configuration.establish_connection
  end
end

EdataEav.establish_connection

# Load Rake tasks
require_relative 'tasks' if defined?(Rake)