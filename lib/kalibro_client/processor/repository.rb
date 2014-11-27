module KalibroClient
  module Processor
    class Repository < Base
      belongs_to :project, class_name: KalibroClient::Processor::Project
      has_many :processings, class_name: KalibroClient::Processor::Processing

      def last_processing
        if get(:has_ready_processing)
          KalibroClient::Processor::Processing.new(get(:last_ready_processing))
        else
          KalibroClient::Processor::Processing.new(get(:last_processing_in_time))
        end
      end

      def has_processing
        get(:has_processing)
      end

      def module_result_history_of(module_result)
        response = post(:module_result_history_of, module_id: module_result.kalibro_module.id)

        JSON.parse(response.body)["module_result_history_of"].map do |date_module_result|
          KalibroClient::Miscellaneous::DateModuleResult.new(date: Time.parse(date_module_result[0]),
                                                              module_result: ModuleResult.new(date_module_result[1]))
        end
      end
    end
  end
end
