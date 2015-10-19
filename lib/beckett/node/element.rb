module Beckett
  class Node::Element < Node::Base
    def to_h
      {}.tap do |element|
        element[:node_name] = node_name
        element[:node_type] = node_type
        element[:children]  = children.map(&:to_h)
      end
    end

    private

    def node_name
      @node_name ||= node.type.upcase
    end

    def node_type
      1
    end
  end
end
