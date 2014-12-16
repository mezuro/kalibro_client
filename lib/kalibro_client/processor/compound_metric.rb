module KalibroClient
  module Processor
    class CompoundMetric < Metric
      attr_reader :script

      def initialize(name, code, scope, description, script)
        @script = script
        super(true, name, code, scope, description)
      end
    end
  end
end
