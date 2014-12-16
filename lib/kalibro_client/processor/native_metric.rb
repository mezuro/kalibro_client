module KalibroClient
  module Processor
    class NativeMetric < Metric
      attr_reader :languages

      def initialize(name, code, scope, description, languages)
        @languages = languages
        super(false, name, code, scope, description)
      end
    end
  end
end
