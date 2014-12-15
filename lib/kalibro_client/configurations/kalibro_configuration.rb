module KalibroClient
  module Configurations
    class KalibroConfiguration < Base
      has_many :metric_configurations, class_name: KalibroClient::Configurations::MetricConfiguration

      def metric_configurations
        get(:metric_configurations)
      end
    end
  end
end