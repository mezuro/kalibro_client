require_relative '../performance'

module Performance
  class MetricCollectorDetailsFindByCode < Base
    def subject
      KalibroClient::Entities::Processor::MetricCollectorDetails.find_by_name("MetricFu").find_metric_by_code("flog")
    end
  end
end

Performance::MetricCollectorDetailsFindByCode.new.run
