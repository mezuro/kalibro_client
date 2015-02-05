require 'kalibro_client/helpers/date_attributes'

module KalibroClient
  module Entities
    module Configurations
      class Base < KalibroClient::Entities::Base
        include DateAttributes

        def self.address
          :configurations_address
        end
      end
    end
  end
end

