module KalibroClient
  module Processor
    class Repository < Base
      belongs_to :project, class_name: KalibroClient::Processor::Project
      has_many :processings, class_name: KalibroClient::Processor::Processing
    end
  end
end