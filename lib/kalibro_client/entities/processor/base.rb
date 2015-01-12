require 'json'

module KalibroClient
  module Entities
    module Processor
      class Base < KalibroClient::Entities::Base
        def self.address
          :processor_address
        end
      end
    end
  end
end

