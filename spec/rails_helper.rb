require 'factory_bot_rails'
require 'active_record'
require 'dotenv'
Dotenv.load

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.before(:suite) do
    EdataEav.establish_connection
  end
end
