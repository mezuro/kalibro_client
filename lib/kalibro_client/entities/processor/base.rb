require 'json'
require 'kalibro_client/helpers/date_attributes'

module KalibroClient
  module Entities
    module Processor
      class Base < KalibroClient::Entities::Base
        include DateAttributes

        def self.address
          :processor_address
        end
      end
    end
  end
end

