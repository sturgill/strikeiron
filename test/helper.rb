require 'test/unit'
require 'strikeiron'
require 'vcr'

class Test::Unit::TestCase
  def setup
    Strikeiron.configure do |config|
      config.user_id  = 'user_id'
      config.password = 'password'
    end
  end
end

VCR.configure do |config|
  config.cassette_library_dir = 'test/cassettes'
  config.hook_into :webmock
  config.filter_sensitive_data('user_id') { Strikeiron.configuration.user_id }
  config.filter_sensitive_data('password') { Strikeiron.configuration.password }
end

# Disable Savon logging to get a cleaner test output
Savon.configure do |config|
  config.log = false
end
