require 'kalibro_client/configurations/base'

module KalibroClient
  module Configurations
    autoload :KalibroConfiguration, 'kalibro_client/configurations/kalibro_configuration'
    autoload :MetricSnapshot, 'kalibro_client/configurations/metric_snapshot'
    autoload :MetricConfiguration, 'kalibro_client/configurations/metric_configuration'
    autoload :ReadingGroup, 'kalibro_client/configurations/reading_group'
    autoload :Reading, 'kalibro_client/configurations/reading'
    autoload :KalibroRange, 'kalibro_client/configurations/kalibro_range'
  end
end
