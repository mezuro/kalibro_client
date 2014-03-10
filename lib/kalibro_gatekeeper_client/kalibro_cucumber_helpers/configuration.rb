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

module KalibroGatekeeperClient
  module KalibroCucumberHelpers
    class Configuration
      attr_accessor :database, :user, :password,
                    :query_file_path, :psql_file_path, :kalibro_home,
                    :tomcat_user, :tomcat_group, :tomcat_restart_command

      def initialize(attributes={})
        self.database               = "kalibro_test"
        self.user                   = "kalibro"
        self.password               = "kalibro"
        self.psql_file_path         = "/tmp/PostgreSQL.sql"
        self.query_file_path        = "/tmp/query"
        self.kalibro_home           = "/usr/share/tomcat6/.kalibro"
        self.tomcat_user            = "tomcat6"
        self.tomcat_group           = "tomcat6"
        self.tomcat_restart_command = "sudo\\ service\\ tomcat6\\ restart"

        attributes.each { |field, value| send("#{field}=", value) if respond_to?("#{field}=") }
      end
    end
  end
end