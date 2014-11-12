module KalibroClient
  module Configurations
    class Reading < Base
      belongs_to :reading_group, class_name: KalibroClient::Configurations::ReadingGroup
      has_many :kalibro_ranges, class_name: KalibroClient::Configurations::KalibroRange
    end
  end
end

