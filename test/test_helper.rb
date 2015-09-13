ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Devise
  class ActionController::TestCase
  		include Devise::TestHelpers
	end

  # Add more helper methods to be used by all tests here...
end
