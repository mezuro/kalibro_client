module KalibroClient
  module Processor
    class MetricResult < Base
      belongs_to :module_result, class_name: KalibroClient::Processor::ModuleResult
    end
  end
end