module KalibroClient
  module Entities
    module Miscellaneous
      class Base
        include HashConverters
        def to_hash(options={})
          hash = Hash.new
          excepts = options[:except].nil? ? [] : options[:except]
          excepts << :kalibro_errors
          fields.each do |field|
            hash = field_to_hash(field).merge(hash) if !excepts.include?(field)
          end
          hash
        end


        def self.to_object value
          value.kind_of?(Hash) ? new(value) : value
        end


        protected

        def fields
          instance_variable_names.each.collect { |variable| variable.to_s.sub(/@/, '').to_sym }
        end

        def instance_variable_names
          instance_variables.map { |var| var.to_s }
        end

      end
    end
  end
end
