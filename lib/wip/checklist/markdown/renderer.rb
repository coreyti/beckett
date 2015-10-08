require 'redcarpet'

module WIP
  module Checklist
    module Markdown
      class Renderer < Redcarpet::Render::Base
        attr_reader :context #, :article, :result

        def initialize
          # puts "Article..."
          @article = Section.new(nil)
          @context = @article
          super
        end

        def to_h
          @article.to_h
        end

        # markdown blocks
        # --------------------------------------------------
        def header(text, level)
          last = @depth || 0
          @depth = level
          @context.rewind(1)

          if @depth > last
            # puts "Descendant Section..."
            @context = Section.new(@context, text)
          end

          if @depth == last
            # puts "Sibling Section..."
            @context = Section.new(@context.parent, text)
          end

          nil
        end

        # markdown spans
        # --------------------------------------------------


        # markdown low-level
        # --------------------------------------------------
        def entity(*args)
          raise "entity: #{args.inspect}"
        end

        def normal_text(*args)
          # puts "normal: #{args.inspect}"
          @context << args[0] # unless is_header?(text)
          args[0] # must return text, or it'll be stripped from headers, etc.
        end


        # markdown callbacks
        # --------------------------------------------------
        def postprocess(*)
          to_h
        end

        private

        def is_header?(text)
          text.match(/^#/) # prefixed with spaces? NO WORKY... no hash here
        end



        class Section # < Hashie::Mash
          attr_reader :header, :children, :content

          def initialize(parent, header = nil)
            # puts "creating Section with header: #{header.inspect}"
            @parent   = parent
            @header   = header
            @children = []
            @content  = []
            parent.children << self if parent
          end

          def to_h
            {}.tap do |h|
              h[:header] = header if header

              if content.length > 0
                h[:content] = []

                content.each do |c|
                  h[:content] << c
                end
              end

              children.each  do |c|
                h[:children] = (h[:children] || []) << c.to_h
              end
            end
          end

          def <<(text)
            # puts "writing content: #{text} into #{header}"
            content << text
          end

          def rewind(count)
            removal = content.pop(count)
            # puts "removed content: #{removal} from #{header}"
          end

          def parent
            @parent || self
          end
        end
      end
    end
  end
end
