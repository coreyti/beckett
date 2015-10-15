module WIP
  module Checklist
    module Markdown
      module Node
        def self.find(node)
          type = node.type.capitalize

          if self.const_defined?(type)
            const_get(type)
          else
            Element
          end
        end

        class Base
          attr_reader :node, :children

          def initialize(node, children)
            @node     = node
            @children = children
          end

          def to_h
            raise NotImplementedError
          end
        end
      end
    end
  end
end
