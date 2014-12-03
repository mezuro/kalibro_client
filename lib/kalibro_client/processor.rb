require 'kalibro_client/processor/base'

module KalibroClient
  module Processor
    autoload :KalibroModule, 'kalibro_client/processor/kalibro_module'
    autoload :MetricResult, 'kalibro_client/processor/metric_result'
    autoload :ModuleResult, 'kalibro_client/processor/module_result'
    autoload :ProcessTime, 'kalibro_client/processor/process_time'
    autoload :Processing, 'kalibro_client/processor/processing'
    autoload :Project, 'kalibro_client/processor/project'
    autoload :DateModuleResult, 'kalibro_client/processor/date_module_result'
    autoload :Repository, 'kalibro_client/processor/repository'
    autoload :Metric, 'kalibro_client/processor/metric'
    autoload :MetricCollector, 'kalibro_client/processor/metric_collector'
  end
end
