module WIP
  module Checklist
    module Markdown
      class Node::Codespan < Node::Text
        private

        def node_name
          'CODESPAN'
        end

        def node_type
          1
        end
      end
    end
  end
end
