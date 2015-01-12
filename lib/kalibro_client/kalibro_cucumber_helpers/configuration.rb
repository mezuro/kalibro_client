# This file is part of KalibroClient
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

module KalibroClient
  module KalibroCucumberHelpers
    class Configuration
      attr_accessor :kalibro_processor_address, :kalibro_configurations_address

      def initialize(attributes={})
        self.kalibro_processor_address = "http://localhost:8082"
        self.kalibro_configurations_address = "http://localhost:8083"

        attributes.each { |field, value| send("#{field}=", value) if respond_to?("#{field}=") }
      end
    end
  end
end
