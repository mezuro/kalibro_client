module KalibroClient
  module Processor
    class CompoundMetric < Metric
      def initialize(name, code, scope, script)
        @script = script
        super(true, name, code, scope)
      end
    end
  end
end
