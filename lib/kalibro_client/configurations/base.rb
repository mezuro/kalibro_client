module KalibroClient
  module Configurations
    class Base < ActiveResource::Base
      self.site="http://localhost:8083"
    end
  end
end