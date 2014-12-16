module KalibroClient
  module Processor
    class Metric < Base
      def initialize(compound, name, code, scope, description="")
        super(compound: compound, name: name, code: code, scope: scope, description: description)
      end
    end
  end
end
