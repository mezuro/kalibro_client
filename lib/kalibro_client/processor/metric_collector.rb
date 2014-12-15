module KalibroClient
  module Processor
    class MetricCollector < Base
      attr_reader :name

      def initialize(attributes)
        @name = attributes["name"]
        @description = attributes["description"]
        @supported_metrics = attributes["supported_metrics"]
      end

      def self.all_names
        get(:names)
      end

      def self.find(name)
        response = post(:find, {name: name})
        parsed_response = JSON.parse(response.body)
        unless parsed_response.include? "error"
          return self.new(parsed_response["metric_collector_details"])
        end
        return nil
      end

      def metric(code)
        @supported_metrics[code]
      end

      def supported_metrics
        supported_metrics = []

        @supported_metrics.each_value do |metric_params|
          supported_metrics << KalibroClient::Processor::Metric.new(false, metric_params["name"], metric_params["code"], metric_params["scope"])
        end

        return supported_metrics
      end
    end
  end
end
