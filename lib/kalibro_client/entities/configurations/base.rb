module KalibroClient
  module Entities
    module Configurations
      class Base < KalibroClient::Entities::Base
        def self.address
          :configurations_address
        end
      end
    end
  end
end

