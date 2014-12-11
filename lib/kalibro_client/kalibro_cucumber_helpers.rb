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

require 'yaml'
require 'kalibro_client/kalibro_cucumber_helpers/configuration'
require 'kalibro_client/kalibro_cucumber_helpers/kalibro_configurations'
require 'kalibro_client/kalibro_cucumber_helpers/kalibro_processor'

module KalibroClient
  module KalibroCucumberHelpers
    @configuration = KalibroClient::KalibroCucumberHelpers::Configuration.new

    def KalibroCucumberHelpers.configure(&config_block)
      config_block.call(@configuration)
    end

    def KalibroCucumberHelpers.configuration
      @configuration
    end

    def KalibroCucumberHelpers.clean_processor
      KalibroClient::KalibroCucumberHelpers::KalibroProcessor.new(site: @configuration.kalibro_processor_address).clear
    end

    def KalibroCucumberHelpers.clean_configuration
      KalibroClient::KalibroCucumberHelpers::KalibroConfigurations.new(site: @configuration.kalibro_configuration_address).clear
    end
  end
end