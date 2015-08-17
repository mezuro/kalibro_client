module KalibroClient
  module Entities
    module Miscellaneous
      class Granularity
        GRANULARITIES = [:METHOD, :CLASS, :PACKAGE, :SOFTWARE, :FUNCTION]

        GRANULARITIES.each do |name|
          self.const_set(name, name)
        end

        PARENTS = {
            METHOD: CLASS,
            CLASS: PACKAGE,
            PACKAGE: SOFTWARE,
            SOFTWARE: SOFTWARE,
            FUNCTION: PACKAGE
        }

        attr_reader :type

        def initialize(type)
          if GRANULARITIES.include?(type)
            @type = type
          else
            raise TypeError.new("Not supported granularity type #{type}")
          end
        end

        def parent
          parent_type = PARENTS[self.type]
          raise ArgumentError.new("Not supported granularity type #{type}") if parent_type.nil?

          return self if self.type == parent_type
          Granularity.new(parent_type)
        end

        def to_s
          self.type.to_s
        end

        def <(other)
          if [[:FUNCTION, :METHOD], [:METHOD, :FUNCTION]].include?([self.type, other.type])
            raise ArgumentError.new('Cannot compare granularities that are not part of the same hierarchy')
          end

          next_type = self.type
          loop do
            next_type = PARENTS[next_type]
            return true if other.type == next_type
            break if next_type == Granularity::SOFTWARE
          end

          false
        end

        def ==(other)
          self.type == other.type
        end

        def <=(other)
          (self == other) || (self < other)
        end

        def >=(other)
          (self == other) || (self > other)
        end

        def >(other)
          !(self <= other)
        end

        def <=>(other_granularity)
          if self < other_granularity
            return -1
          elsif self > other_granularity
            return 1
          else
            return 0
          end
        end
      end
    end
  end
end
