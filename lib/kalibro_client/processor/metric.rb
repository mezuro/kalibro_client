module KalibroClient
  module Processor
    class Metric < Base
      def initialize(compound, name, code, scope)
        super(compound: compound, name: name, code: code, scope: scope)
      end
    end
  end
end
