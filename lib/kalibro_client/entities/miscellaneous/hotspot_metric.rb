module KalibroClient
  module Entities
    module Miscellaneous
      class HotspotMetric < NativeMetric
        attr_accessor :languages, :metric_collector_name

        def initialize(name, code, languages, metric_collector_name)
          super(name, code, KalibroClient::Entities::Miscellaneous::Granularity.new(:SOFTWARE), languages, metric_collector_name, 'HotspotMetricSnapshot')
        end
      end
    end
  end
end
