module KalibroClient
  module Configurations
    class KalibroConfiguration < Base
      has_many :metric_configurations, class_name: KalibroClient::Configurations::MetricConfiguration
    end
  end
end