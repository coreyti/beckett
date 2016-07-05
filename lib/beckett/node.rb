module Beckett
  module Node
    def self.find(node)
      type = node.type.capitalize

      if self.const_defined?(type)
        const_get(type)
      else
        Element
      end
    end

    class Base
      $position = 0
      attr_reader :node, :name, :children, :position

      def initialize(node, options = {})
        @node     = node
        @children = []
        @options  = options
        @position = $position
        $position += 1
      end

      def inspect
        "<#{node_name} position=#{position}>"
      end

      def to_s
        inspect
      end

      def to_h
        raise NotImplementedError
      end

      def <<(nodes)
        @children += ([nodes].flatten)
      end

      def depth
        @options[:depth] || 0
      end

      def name
        node_name.to_s
      end

      private

      def node_name
        @node_name ||= node.type.upcase
      end
    end
  end
end
