module WIP
  module Checklist
    module Markdown
      class Renderer < Kramdown::Converter::Base
        DISPATCHER = Hash.new { |h, k| h[k] = "convert_#{k}" }

        def initialize(root, options = {})
          super
          @stack = []
        end

        def convert(node)
          send(DISPATCHER[node.type], node)
        end

        private

        def convert_root(node)
          build(node).to_h
        end

        # ---

        def convert_header(node)
          build(node)
        end

        def convert_p(node)
          build(node)
        end

        # ---

        def convert_blank(node)
          nil
        end

        def convert_text(node)
          Node.find(node).new(node)
        end

        # ---

        def build(node)
          case node.type
          when :root
            context = Node::Root.new(node)
            @stack.push(context)
            inner(node)
          when :header
            level = node.options[:level]

            while @stack.length > level
              @stack.pop
            end

            parent = @stack.last

            context = if level == 1
              Node::Article.new(node)
            else
              Node::Section.new(node)
            end
            @stack.push(context)

            header = Node::Header.new(node)
            header.insert(inner(node))
            context.insert(header)
            parent.insert(context)
          else
            context = @stack.last
            content = Node.find(node).new(node)
            content.insert(inner(node))
            context.insert(content)
          end

          context
        end

        def inner(node)
          node.children.map { |child| convert(child) }.compact
        end
      end
    end
  end
end
