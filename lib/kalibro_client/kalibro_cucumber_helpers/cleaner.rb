require 'likeno/request_methods'

module KalibroClient
  module KalibroCucumberHelpers
    class Cleaner
      include Likeno::RequestMethods

      attr_reader :address

      def initialize(address)
        @address = address
      end

      def endpoint
        'tests'
      end

      def clean_database
        request('clean_database', {}, :post)
      end
    end
  end
end
