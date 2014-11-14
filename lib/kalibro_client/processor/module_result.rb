module KalibroClient
  module Processor
    class ModuleResult < Base
      has_one :kalibro_module, class_name: KalibroClient::Processor::KalibroModule
      has_many :children, class_name: KalibroClient::Processor::ModuleResult
      has_many :metric_results, class_name: KalibroClient::Processor::MetricResult
      belongs_to :parent, class_name: KalibroClient::Processor::ModuleResult
      belongs_to :processing, class_name: KalibroClient::Processor::Processing
    end
  end
end