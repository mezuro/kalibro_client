module KalibroClient
  module Processor
    class MetricCollector < Base

      def self.all_names
        response = get(:all_names)
        JSON.parse(response)["all_names"]
      end

      def self.find(name)
        response = post(:find, {name: name})
        parsed_response = JSON.parse(response.body)
        unless parsed_response.include? "error"
          return self.new parsed_response["metric_collector_details"]
        end
        return nil
      end
    end
  end
end
