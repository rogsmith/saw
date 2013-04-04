$:.unshift(File.dirname(__FILE__) + '/../..')
$:.unshift(File.dirname(__FILE__) + '/../../lib')
schema_file = File.join(File.dirname(__FILE__), '..', 'schema.rb')

ENV["RAILS_ENV"] = "test"

require 'rubygems'
require 'test/unit'
require 'active_record'
require 'active_record/fixtures'
require 'active_support'
require 'active_support/test_case'
require 'action_controller'
require 'action_controller/test_case'
#require 'action_controller/test_process'
#require 'action_controller/integration'
#require 'init'

config = YAML::load(IO.read(File.join(File.dirname(__FILE__), '..', 'database.yml')))[ENV['DB'] || 'test']
ActiveRecord::Base.configurations = config
ActiveRecord::Base.establish_connection(config)

ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + "/models.log")
ActionController::Base.logger = Logger.new(File.dirname(__FILE__) + "/controllers.log")

load(schema_file) if File.exist?(schema_file)

if ActiveSupport::TestCase.method_defined?(:fixture_path)
  Test::Unit::TestCase.fixture_path = File.join(File.dirname(__FILE__), '..', 'fixtures')
  $:.unshift(Test::Unit::TestCase.fixture_path)
end

class Test::Unit::TestCase #:nodoc:
  # Turn off transactional fixtures if you're working with MyISAM tables in MySQL
  # self.use_transactional_fixtures = true

  # Instantiated fixtures are slow
  # self.use_instantiated_fixtures  = true
end