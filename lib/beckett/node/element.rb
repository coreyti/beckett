module Beckett
  class Node::Element < Node::Base
    def to_h
      {}.tap do |element|
        element[:node_name]  = node_name
        element[:node_type]  = node_type
        # NOTE: might add attributes as `nil` or empty Hash at a later date...
        element[:attributes] = node_attributes if node_attributes
        element[:children]   = children.map(&:to_h)
      end
    end

    private

    def node_attributes
      unless defined?(@node_attributes)
        @node_attributes = node.attr
        @node_attributes = nil if @node_attributes.empty?
      end
      @node_attributes
    end

    def node_name
      @node_name ||= node.type.upcase
    end

    def node_type
      1
    end
  end
end
