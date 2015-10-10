module WIP::Checklist
  module Markdown
    class Node::Section < Node
      attr_reader :header

      def initialize(parent, *args)
        super
        @header = args[0]
        @level  = args[1]
      end

      def node_name
        'SECTION'
      end

      def node_type
        1
      end

      def node_text
        nil
      end

      # ---

      def allow?(name, level = 0)
        if ['P'].include?(name)
          return true
        end

        ['SECTION'].include?(name) && level > @level
      end
    end
  end
end
