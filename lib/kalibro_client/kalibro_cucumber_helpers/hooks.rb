After('@kalibro_processor_restart') do
  KalibroClient::KalibroCucumberHelpers.clean_processor
end

After('@kalibro_configuration_restart') do
  KalibroClient::KalibroCucumberHelpers.clean_configuration
end
