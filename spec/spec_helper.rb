# This file is part of KalibroGatekeeperClient
# Copyright (C) 2013  it's respectives authors (please see the AUTHORS file)
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

require 'mocha/api'

# Test coverage report
require 'simplecov'
require 'coveralls'

SimpleCov.start do
  formatter SimpleCov::Formatter::MultiFormatter[
                Coveralls::SimpleCov::Formatter,
                SimpleCov::Formatter::HTMLFormatter
              ]
  add_group "Entities", "lib/kalibro_gatekeeper_client/entities"
  add_group "Errors", "lib/kalibro_gatekeeper_client/errors"
  add_group "Helpers", "lib/kalibro_gatekeeper_client/helpers"
  add_group "Cucumber Helpers", "lib/kalibro_gatekeeper_client/kalibro_cucumber_helpers"

  add_filter "/spec/"
  add_filter "/features/"

  coverage_dir 'coverage/rspec'
end

require 'kalibro_gatekeeper_client'

require 'factory_girl'
FactoryGirl.find_definitions

RSpec.configure do |config|
  # Mock Framework
  config.mock_with :mocha

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  # Colors
  config.color = true
end