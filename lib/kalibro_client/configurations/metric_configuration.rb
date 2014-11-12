module KalibroClient
  module Configurations
    class MetricConfiguration < Base
      has_one :metric_snapshot, class_name: KalibroClient::Configurations::MetricSnapshot
    end
  end
end