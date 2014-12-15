module KalibroClient
  module Configurations
    class Reading < Base
      belongs_to :reading_group, class_name: KalibroClient::Configurations::ReadingGroup
      has_many :kalibro_ranges, class_name: KalibroClient::Configurations::KalibroRange

      self.prefix = "/reading_groups/:reading_group_id/"

      def reading_group_id=(reading_group_id)
        @attributes["reading_group_id"] = reading_group_id
        @prefix_options[:reading_group_id] = @attributes["reading_group_id"]
      end

      def self.find(id)
        self.prefix = "/reading_groups/:all/"
        reading = super(id)
        reading.prefix_options[:reading_group_id] = reading.reading_group_id
        self.prefix = "/reading_groups/:reading_group_id/"
        reading
      end
    end
  end
end

