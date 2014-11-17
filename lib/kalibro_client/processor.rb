require 'kalibro_client/processor/base'

module KalibroClient
  module Processor
    autoload :KalibroModule, 'kalibro_client/processor/kalibro_module'
    autoload :MetricResult, 'kalibro_client/processor/metric_result'
    autoload :ModuleResult, 'kalibro_client/processor/module_result'
    autoload :ProcessTime, 'kalibro_client/processor/process_time'
    autoload :Processing, 'kalibro_client/processor/processing'
    autoload :Project, 'kalibro_client/processor/project'
    autoload :Repository, 'kalibro_client/processor/repository'
  end
end