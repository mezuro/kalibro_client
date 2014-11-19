module KalibroClient
  module Processor
    class Repository < Base
      belongs_to :project, class_name: KalibroClient::Processor::Project
      has_many :processings, class_name: KalibroClient::Processor::Processing

      def last_processing
        if get(:has_ready_processing)
          get(:last_ready_processing)
        else
          get(:last_processing_in_time)
        end
      end

      def has_processing
        get(:has_processing)
      end
    end
  end
end
