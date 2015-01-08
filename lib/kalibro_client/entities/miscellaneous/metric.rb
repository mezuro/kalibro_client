require 'kalibro_client/helpers/hash_converters'

module KalibroClient
  module Entities
    module Miscellaneous
      class Metric < KalibroClient::Entities::Miscellaneous::Base
        attr_accessor :type, :name, :code, :scope, :description

        def initialize(type, name, code, scope)
          @type = type
          @name = name
          @code = code
          @scope = scope
          @description = ""
        end
      end
    end
  end
end
