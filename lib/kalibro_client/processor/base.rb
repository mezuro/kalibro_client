module KalibroClient
  module Processor
    class Base < ActiveResource::Base
      self.site = "http://localhost:8082"
    end
  end
end