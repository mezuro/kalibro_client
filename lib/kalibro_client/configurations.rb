require 'kalibro_client/configurations/base'

module KalibroClient
  module Configurations
    autoload :MetricSnapshot, 'kalibro_client/configurations/metric_snapshot'
    autoload :MetricConfiguration, 'kalibro_client/configurations/metric_configuration'
  end
end