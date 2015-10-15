module WIP
  module Checklist
    module Markdown
      class Renderer < Kramdown::Converter::Base
        DISPATCHER = Hash.new { |h, k| h[k] = "convert_#{k}" }

        def initialize(root, options = {})
          super
          @stack = []
        end

        def debug(type, node)
          # puts "convert #{type.inspect}:\n - #{node.inspect}"
        end

        def convert(node)
          result = send(DISPATCHER[node.type], node)
          result ? result.to_h : nil
        end

        private

        def convert_root(node)
          debug(:root, node)
          @root = node
          Node.find(node).new(node, inner(node.children))
        end

        # ---

        def convert_header(node)
          debug(:header, node)
          children = fragment(@root, node)
          header   = children.shift
          header   = Node::Header.new(header, inner(header.children))
          Node::Article.new(node, [header.to_h] + inner(children))
        end

        def convert_p(node)
          debug(:p, node)
          Node.find(node).new(node, inner(node.children))
        end

        # ---

        def convert_blank(node)
          debug(:blank, node)
          nil
        end

        def convert_text(node)
          debug(:text, node)
          Node.find(node).new(node, nil)
        end

        # ---

        def inner(children)
          children.map { |child| convert(child) }.compact
        end

        def fragment(parent, context)
          type  = context.type
          level = context.options[:level]
          nodes = parent.children
          index = nodes.index(context)
          tail  = nodes[(index + 1)..-1]
          count = tail.index { |node|
            node.type == type && (node.options[:level] == level)
          } || tail.length()

          nodes[index..(index + count)]
        end
      end
    end
  end
end
