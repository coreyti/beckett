module WIP::Checklist
  module Markdown
    class Node::Article < Node
      attr_accessor :header # hmm

      def initialize(parent, *args)
        super
      end

      def node_name
        'ARTICLE'
      end

      def node_type
        1
      end

      def node_text
        nil
      end

      # ---

      def allow?(name, level = 0)
        true
      end
    end
  end
end
