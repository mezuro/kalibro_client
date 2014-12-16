module KalibroClient
  module Processor
    class Metric < Base
      def initialize(compound, name, code, scope, description, languages)
        super(compound: compound, name: name, code: code, scope: scope,
              description: description, languages: languages)
      end
    end
  end
end
