require 'json'

module KalibroClient
  module Entities
    module Processor
      class Base < KalibroClient::Entities::Base

        attr_accessor :created_at, :updated_at
        def self.address
          :processor_address
        end
      end
    end
  end
end

