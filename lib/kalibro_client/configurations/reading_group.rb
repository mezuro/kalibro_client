module KalibroClient
  module Configurations
    class ReadingGroup < Base
      has_many :readings, class_name: KalibroClient::Configurations::Reading
    end
  end
end

