module KalibroClient
  module Processor
    class CompoundMetric < Metric
      attr_reader :script

      def initialize(name, code, scope, script)
        @script = script
        super(true, name, code, scope)
      end
    end
  end
end
