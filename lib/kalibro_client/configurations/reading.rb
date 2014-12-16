module KalibroClient
  module Configurations
    class Reading < Base
      belongs_to :reading_group, class_name: KalibroClient::Configurations::ReadingGroup
      has_many :kalibro_ranges, class_name: KalibroClient::Configurations::KalibroRange

      def save
        default_prefix = Reading.prefix
        Reading.prefix = "/reading_groups/:reading_group_id/"
        @prefix_options[:reading_group_id] = reading_group_id
        begin
          saved = super
        ensure
          Reading.prefix = default_prefix
        end
        return saved
      end

      def destroy
        default_prefix = Reading.prefix
        Reading.prefix = "/reading_groups/:reading_group_id/"
        @prefix_options[:reading_group_id] = reading_group_id
        begin
          destroyed = super
        ensure
          Reading.prefix = default_prefix
        end
        return destroyed
      end
    end
  end
end

