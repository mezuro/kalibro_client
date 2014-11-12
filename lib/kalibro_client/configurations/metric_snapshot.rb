module KalibroClient
  module Configurations
    class MetricSnapshot < Base
      has_one :metric_configuration, class_name: KalibroClient::Configurations::MetricConfiguration
    end
  end
end