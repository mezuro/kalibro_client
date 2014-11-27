module KalibroClient
  module Miscellaneous
    class DateModuleResult
      attr_reader :date, :module_result

      def initialize(attributes={})
        @date = attributes[:date]
        @module_result = attributes[:module_result]
      end
    end
  end
end