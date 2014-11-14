module KalibroClient
  module Processor
    class Project < Base
      has_many :repositories, class_name: KalibroClient::Processor::Repository
    end
  end
end