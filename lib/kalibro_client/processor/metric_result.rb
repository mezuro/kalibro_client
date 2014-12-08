module KalibroClient
  module Processor
    class MetricResult < Base
      belongs_to :module_result, class_name: KalibroClient::Processor::ModuleResult

      def metric_configuration
        KalibroClient::Configurations::MetricConfiguration.new(get(:metric_configuration))
      end
    end
  end
end
