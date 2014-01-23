# This file is part of KalibroGem
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

require 'kalibro_gem/kalibro_cucumber_helpers'

Before do
  if !$dunit
    command = "#{__dir__}/scripts/put_kalibro_on_test_mode.sh \\
                #{KalibroGem::KalibroCucumberHelpers.configuration.kalibro_home} \\
                #{KalibroGem::KalibroCucumberHelpers.configuration.tomcat_restart_command} \\
                #{KalibroGem::KalibroCucumberHelpers.configuration.tomcat_user} \\
                #{KalibroGem::KalibroCucumberHelpers.configuration.tomcat_group}"
    system command

    command = "#{__dir__}/scripts/prepare_kalibro_query_file.sh \\
                #{KalibroGem::KalibroCucumberHelpers.configuration.psql_file_path} \\
                #{KalibroGem::KalibroCucumberHelpers.configuration.query_file_path}"
    system command

    command = "#{__dir__}/scripts/delete_all_kalibro_entries.sh \\
               #{KalibroGem::KalibroCucumberHelpers.configuration.password} \\
               #{KalibroGem::KalibroCucumberHelpers.configuration.database} \\
               #{KalibroGem::KalibroCucumberHelpers.configuration.query_file_path}"
    system command

    $dunit = true
  end
end

After ('@kalibro_restart') do
  command = "#{__dir__}/scripts/delete_all_kalibro_entries.sh \\
               #{KalibroGem::KalibroCucumberHelpers.configuration.password} \\
               #{KalibroGem::KalibroCucumberHelpers.configuration.database} \\
               #{KalibroGem::KalibroCucumberHelpers.configuration.query_file_path}"
  system command
end

at_exit do
  command = "#{__dir__}/scripts/return_kalibro_from_test_mode.sh \\
                #{KalibroGem::KalibroCucumberHelpers.configuration.kalibro_home} \\
                #{KalibroGem::KalibroCucumberHelpers.configuration.tomcat_restart_command}"
  system command
end