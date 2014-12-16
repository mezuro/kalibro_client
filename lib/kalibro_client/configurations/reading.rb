module KalibroClient
  module Configurations
    class Reading < Base
      belongs_to :reading_group, class_name: KalibroClient::Configurations::ReadingGroup
      has_many :kalibro_ranges, class_name: KalibroClient::Configurations::KalibroRange

      def save
        default_prefix = Reading.prefix
        Reading.prefix = "/reading_groups/:reading_group_id/"
        begin
          @prefix_options[:reading_group_id] = reading_group.id
          saved = super
        rescue NoMethodError, ActiveResource::ResourceNotFound, ActiveResource::BadRequest
          saved = false
        ensure
          Reading.prefix = default_prefix
        end
        return saved
      end

      def destroy
        default_prefix = Reading.prefix
        Reading.prefix = "/reading_groups/:reading_group_id/"
        begin
          @prefix_options[:reading_group_id] = reading_group.id
          super
        rescue NoMethodError, ActiveResource::ResourceNotFound
        ensure
          Reading.prefix = default_prefix
        end
      end
    end
  end
end

