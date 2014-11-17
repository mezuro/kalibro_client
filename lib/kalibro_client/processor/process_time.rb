module KalibroClient
  module Processor
    class ProcessTime < Base
      belongs_to :processing, class_name: KalibroClient::Processor::Processing
    end
  end
end