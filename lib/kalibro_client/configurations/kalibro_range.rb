module KalibroClient
  module Configurations
    class KalibroRange < Base
      belongs_to :reading, class_name: KalibroClient::Configurations::Reading
      belongs_to :metric_configuration, class_name: KalibroClient::Configurations::MetricConfiguration
    end
  end
end

