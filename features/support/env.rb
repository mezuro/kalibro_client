# SimpleCov for test coverage report
require 'simplecov'
SimpleCov.start do
  add_group "Entities", "lib/kalibro_gem/entities"
  add_group "Errors", "lib/kalibro_gem/errors"
  add_group "Helpers", "lib/kalibro_gem/helpers"
  add_group "Cucumber Helpers", "lib/kalibro_gem/kalibro_cucumber_helpers"

  add_filter "/spec/"
  add_filter "/features/"

  coverage_dir 'coverage/cucumber'
end

# Kalibro hooks
require 'kalibro_gem/kalibro_cucumber_helpers/hooks'

# Configuring the right hooks
KalibroGem::KalibroCucumberHelpers.configure_from_yml("#{__dir__}/kalibro_cucumber_helpers.yml")

# The gem itself
require 'kalibro_gem'

require 'factory_girl'
FactoryGirl.find_definitions
