module KalibroClient
  module Processor
    class KalibroModule < Base
      has_many :module_results, class_name: KalibroClient::Processor::ModuleResult
    end
  end
end