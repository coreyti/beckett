module WIP::Checklist
  module Markdown
    class Node::Paragraph < Node
      def initialize(parent, *args)
        super
        self << Text.new(self, @args[0])
      end

      def node_name
        'P'
      end

      def node_type
        1
      end

      def node_text
        nil
      end

      # ---

      # def paragraph(text)
      #   parent.paragraph(text)
      # end
    end
  end
end
