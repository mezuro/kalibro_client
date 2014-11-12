module KalibroClient
  module Configurations
    class MetricConfiguration < Base
      belongs_to :metric_snapshot, class_name: KalibroClient::Configurations::MetricSnapshot
    end
  end
end