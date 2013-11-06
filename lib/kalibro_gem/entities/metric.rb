module KalibroGem
  module Entities
    class Metric < Model
      
      attr_accessor :name, :compound, :scope, :description, :script, :language

      def languages
        @language
      end

      def languages=(languages)
        @language = languages
      end

      def language=(value)
        @language = self.class.to_objects_array value
      end

    end
  end
end