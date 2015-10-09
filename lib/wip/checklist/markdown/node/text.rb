module WIP::Checklist
  module Markdown
    class Node::Text < Node
      def initialize(parent, *args)
        super
        @text = @args[0]
      end

      def node_name
        '#text'
      end

      def node_type
        3
      end

      def node_text
        @text
      end
    end
  end
end
