module Beckett
  class Node::Br < Node::Element
    def to_h
      {}.tap do |element|
        element[:node_name] = node_name
        element[:node_type] = node_type
      end
    end
  end
end
