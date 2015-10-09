module WIP
  module Checklist
    module Markdown
      class Node
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

        # def rewind(node_name = nil)
        #   if node_name.nil? || (children.last && children.last.node_name == node_name)
        #     children.pop(count)
        #   end
        # end

        def node_name
          raise NotImplementedError
        end

        def node_type
          raise NotImplementedError
        end

        def node_text
          raise NotImplementedError
        end

        def header
          nil
        end
      end
    end
  end
end
