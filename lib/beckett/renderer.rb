module Beckett
  class Renderer < Kramdown::Converter::Base
    DISPATCHER = Hash.new { |h, k|
      method = :"convert_#{k}"
      h[k] = Renderer.method_defined?(method) ? method : :convert_node
    }

    def initialize(root, options = {})
      super
      @stack = []
    end

    def convert(node)
      send(DISPATCHER[node.type], node)
    end

    protected

    def convert_root(node)
      build(node).to_h
    end

    def convert_node(node)
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
      Node.find(node).new(node).tap do |result|
        push(result)
        inner(node)
        pop
      end
    end

    def build_section(node)
      level = node.options[:level]

      while @stack.length > level
        pop
      end

      if level == 1
        Node::Article.new(node)
      else
        Node::Section.new(node)
      end
    end

    def context
      @stack.last
    end

    def inner(node)
      node.children.each do |child|
        if child.type == :header
          build_section(child).tap do |result|
            context << result
            push(result)
          end
        end

        convert(child).tap do |result|
          context << result unless result.nil?
        end
      end
    end

    def push(context)
      if debug?
        @indent ||= 0
        puts "#{' ' * @indent}#{context}"
        @indent += 2
      end

      @stack.push(context)
    end

    def pop
      context = @stack.pop

      if debug?
        @indent -= 2
        puts "#{' ' * @indent}#{context}".sub(/^(\s*)<([A-Z]+).*/, '\1</\2>')
      end
    end

    # ---

    def debug?
      if @debug == nil
        @debug = (ENV['DEBUG'] == 'true')
      end
      @debug
    end
  end
end
