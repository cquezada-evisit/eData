require 'factory_bot_rails'
require 'active_record'
require 'dotenv'
require 'pry'
require 'bundler/setup'
require 'edata_eav'

Dotenv.load

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    EdataEav.establish_connection
  end

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
