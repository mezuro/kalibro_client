module KalibroClient
  module Entities
    module Configurations
      class Base < KalibroClient::Entities::Base
        attr_accessor :created_at, :updated_at
        def self.address
          :configurations_address
        end
      end
    end
  end
end

