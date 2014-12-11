module KalibroClient
  module KalibroCucumberHelpers
    class KalibroProcessor < ActiveResource::Base
      def initialize(attributes={site: 'http://localhost:8082'})
        super()
        self.class.site = attributes[:site]
        self.class.element_name = 'tests'
        @persisted = true
      end

      def clear
        post(:clean_database)
      end
    end
  end
end