module WIP
  module Checklist
    module Markdown
      class Node
        attr_reader :parent

        def initialize(parent, *args)
          @parent   = parent
          @args     = args
          @children = []
        end

        def parent
          @parent || self
        end

        def to_h
          {}.tap do |h|
            h[:node_name] = node_name
            h[:node_type] = node_type
            h[:node_text] = node_text if node_text
            h[:header]    = header    if header
            h[:children]  = []        unless @children.empty?

            @children.each do |object|
              child = object.respond_to?(:to_h) ? object.to_h : object
              h[:children] = (h[:children] || []) << child
            end
          end
        end

        def <<(child)
          # puts "adding #{child.inspect} to #{@children}"
          @children << child
        end

        def node_name
          raise NotImplementedError
        end

        def node_type
          raise NotImplementedError
        end

        def node_text
          raise NotImplementedError
        end

        # ---

        def allow?(name, level = 0)
          false
        end

        # ---

        def header
          nil
        end

        def section(text, level)
          Section.new(self, text, level).tap do |add|
            self << add
          end
        end

        def paragraph(text)
          Paragraph.new(self, text).tap do |add|
            self << add
          end
        end
      end
    end
  end
end
