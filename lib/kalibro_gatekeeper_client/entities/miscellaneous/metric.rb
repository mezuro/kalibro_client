module KalibroClient
  module Miscellaneous
    class Metric
      attr_accessor :type, :name, :code, :scope, :description

      def initialize(type, name, code, scope)
        @type = type
        @name = name
        @code = code
        @scope = scope
        @description = ""
      end
    end
  end
end