require 'active_resource'

# FIXME
# Extracted from ActiveResource code on master branch
# https://github.com/rails/activeresource/blob/master/lib/active_resource/associations.rb
# Remove it as soon as a new version gets released
class ActiveResource::Base
  def self.defines_has_one_finder_method(method_name, association_model)
    ivar_name = :"@#{method_name}"
    define_method(method_name) do
      if instance_variable_defined?(ivar_name)
        instance_variable_get(ivar_name)
      elsif attributes.include?(method_name)
        attributes[method_name]
      elsif association_model.respond_to?(:singleton_name)
        instance_variable_set(ivar_name, association_model.find(:params => {:"#{self.class.element_name}_id" => self.id}))
      else
        instance_variable_set(ivar_name, association_model.find(:one, :from => "/#{self.class.collection_name}/#{self.id}/#{method_name}#{self.class.format_extension}"))
      end
    end
  end
end

require "kalibro_client/version"
require "kalibro_client/configurations"

module KalibroClient
  # Your code goes here...
end
