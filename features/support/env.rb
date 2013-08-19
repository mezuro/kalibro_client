# SimpleCov for test coverage report
require 'simplecov'
SimpleCov.start do
  add_group "Entities", "lib/kalibro_entities/entities"
  add_group "Errors", "lib/kalibro_entities/errors"
  add_group "Helpers", "lib/kalibro_entities/helpers"
  add_group "Cucumber Helpers", "lib/kalibro_entities/kalibro_cucumber_helpers"

  add_filter "/spec/"

  coverage_dir 'coverage/cucumber'
end

# Kalibro hooks
require 'kalibro_entities/kalibro_cucumber_helpers/hooks'

# Configuring the right hooks
KalibroEntities::KalibroCucumberHelpers.configure_from_yml("#{__dir__}/kalibro_cucumber_helpers.yml")

# The gem itself
require 'kalibro_entities'

require 'factory_girl'
FactoryGirl.find_definitions
