module KalibroClient
  module Configurations
    class MetricConfiguration < Base
      belongs_to :metric_snapshot, class_name: KalibroClient::Configurations::MetricSnapshot
      belongs_to :kalibro_configuration, class_name: KalibroClient::Configurations::KalibroConfiguration
      has_many :kalibro_ranges, class_name: KalibroClient::Configurations::KalibroRange

      def initialize(weight=0.0, aggregation_form=:AVERAGE, reading_group_id=nil)
        super(weight: weight, aggregation_form: aggregation_form, reading_group_id: reading_group_id)
      end
    end
  end
end
