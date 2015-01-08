module KalibroClient
  module Miscellaneous
    class CompoundMetric < Metric
      attr_accessor :script
      def initialize(name, code, scope, script)
        super('CompoundMetricSnapshot', name, code, scope)
        @script = script
      end
    end
  end
end