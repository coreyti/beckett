module Beckett
  class Node::Codeblock < Node::Element
    def to_h
      super.tap do |element|
        element.delete(:children)
        element[:node_text] = node_text
      end
    end

    private

    def node_text
      node.value.strip
    end
  end
end
