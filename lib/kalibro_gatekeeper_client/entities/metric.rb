module KalibroGatekeeperClient
  module Entities
    class Metric < Model
      attr_accessor :name, :code, :compound, :scope, :description, :script, :language

      def languages
        @language
      end

      def languages=(languages)
        @language = languages
      end

      def language=(value)
        @language = self.class.to_objects_array value
      end

      def compound
        return true if @compound == true || @compound =~ (/(true|t|yes|y|1)$/i)
        return false if @compound == false || @compound.empty? || @compound =~ (/(false|f|no|n|0)$/i)
        raise ArgumentError.new("invalid value for Boolean: \"#{@compound}\"")
      end
    end
  end
end