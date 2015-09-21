module KalibroClient
  module Errors
    class RecordInvalid < Standard
      attr_reader :record

      def initialize(record = nil)
        message = if record
          @record = record
          errors = @record.kalibro_errors.join(', ')
          "Record invalid: #{errors}"
        else
          'Record invalid'
        end

        super(message)
      end
    end
  end
end
