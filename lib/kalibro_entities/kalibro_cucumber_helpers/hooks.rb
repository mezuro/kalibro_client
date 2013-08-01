require 'kalibro_entities/kalibro_cucumber_helpers'

Before do
  if !$dunit
    command = "#{__dir__}/scripts/put_kalibro_on_test_mode.sh \\
                #{KalibroEntities::KalibroCucumberHelpers.configuration.kalibro_home} \\
                #{KalibroEntities::KalibroCucumberHelpers.configuration.tomcat_restart_command} \\
                #{KalibroEntities::KalibroCucumberHelpers.configuration.tomcat_user} \\
                #{KalibroEntities::KalibroCucumberHelpers.configuration.tomcat_group}"
    system command

    command = "#{__dir__}/scripts/prepare_kalibro_query_file.sh \\
                #{KalibroEntities::KalibroCucumberHelpers.configuration.psql_file_path} \\
                #{KalibroEntities::KalibroCucumberHelpers.configuration.query_file_path}"
    system command

    $dunit = true
  end
end

After ('@kalibro_restart') do
  command = "#{__dir__}/scripts/delete_all_kalibro_entries.sh \\
               #{KalibroEntities::KalibroCucumberHelpers.configuration.password} \\
               #{KalibroEntities::KalibroCucumberHelpers.configuration.database} \\
               #{KalibroEntities::KalibroCucumberHelpers.configuration.query_file_path}"
  system command
end

at_exit do
  command = "#{__dir__}/scripts/return_kalibro_from_test_mode.sh \\
                #{KalibroEntities::KalibroCucumberHelpers.configuration.kalibro_home} \\
                #{KalibroEntities::KalibroCucumberHelpers.configuration.tomcat_restart_command}"
  system command
end