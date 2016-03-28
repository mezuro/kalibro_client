module KalibroClient
  module Errors
    class RecordInvalid < Likeno::Errors::Standard
      def initialize(record = nil)
        STDERR.puts 'DEPRECATED: KalibroClient::Errors::RecordInvalid will be replaced by Likeno::Errors::RecordInvalid.'
        super(record)
      end
    end
  end
end
