module Beckett
  class Node::Text < Node::Base
    def to_h
      {}.tap do |element|
        element[:node_name] = node_name
        element[:node_type] = node_type
        element[:node_text] = node_text
      end
    end

    def nil?
      # improves list rendering.
      node_text.strip.empty?
    end

    private

    def node_name
      '#text'
    end

    def node_text
      node.value
    end

    def node_type
      3
    end
  end
end
