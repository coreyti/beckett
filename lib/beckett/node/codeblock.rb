module Beckett
  class Node::Codeblock < Node::Element
    def to_h
      {}.tap do |element|
        element[:node_name] = node_name
        element[:node_type] = node_type
        element[:node_text] = node_text
      end
    end

    private

    def node_text
      node.value.strip
    end
  end
end
