module KalibroClient
  module Miscellaneous
    class DateMetricResult
      attr_reader :date, :metric_result

      def initialize(attributes={})
        @date = attributes[:date]
        @metric_result = attributes[:metric_result]
      end
    end
  end
end
