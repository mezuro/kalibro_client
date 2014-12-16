module KalibroClient
  module Configurations
    class MetricConfiguration < Base
      belongs_to :metric_snapshot, class_name: KalibroClient::Configurations::MetricSnapshot
      belongs_to :kalibro_configuration, class_name: KalibroClient::Configurations::KalibroConfiguration
      has_many :kalibro_ranges, class_name: KalibroClient::Configurations::KalibroRange

      def initialize(weight=0.0)
        super(weight: weight)
      end
    end
  end
end
