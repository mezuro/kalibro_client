module KalibroClient
  module Configurations
    class MetricConfiguration < Base
      belongs_to :metric_snapshot, class_name: KalibroClient::Configurations::MetricSnapshot
      has_many :kalibro_ranges, class_name: KalibroClient::Configurations::KalibroRangesS
    end
  end
end