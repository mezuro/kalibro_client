module KalibroClient
  module Processor
    class Processing < Base
      belongs_to :repository, class_name: KalibroClient::Processor::Repository
      belongs_to :root_module_result, class_name: KalibroClient::Processor::ModuleResult
      has_many :process_times, class_name: KalibroClient::Processor::ProcessTime
      has_many :module_results, class_name: KalibroClient::Processor::ModuleResult
    end
  end
end