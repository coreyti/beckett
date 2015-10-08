require 'redcarpet'
require 'pp'

module WIP
  module Checklist
    module Markdown
      class Renderer < Redcarpet::Render::Base
        attr_reader :document, :context #, :result

        def initialize
          @document = Document.new
          @context  = document
          # @result   = {
          #   headers:  [],
          #   sections: []
          # }
          super
        end

        def inspect
          document.inspect
        end

        def postprocess(*)
          inspect
        end
        # def to_h
        #   {}.tap do |hash|
        #     hash[]
        #   end
        # end

        def header(*args)
          # puts "header: #{args.inspect}"
          @context.rewind(1)
          @context = @context.parent
          @context = Section.new(@context, args[0])

          # result[:headers] << text
          nil
        end

        def entity(*args)
          raise "entity: #{args.inspect}"
        end

        def normal_text(*args)
          # puts "normal: #{args.inspect}"
          @context << args[0] # unless is_header?(text)
          args[0] # must return text, or it'll be stripped from headers, etc.
        end

        private

        def is_header?(text)
          text.match(/^#/) # prefixed with spaces? NO WORKY... no hash here
        end

        # require 'hashie'

        class Document # < Hashie::Mash
          attr_reader :children #, :content

          def initialize
            @children = []
            # @content  = []
          end

          def inspect
            c = [].tap do |a|
              children.each do |child|
                a << child.inspect
              end
            end
            { children: c }
          end

          def parent
            self
          end

          def <<(text)
            # content << text
          end

          def rewind(count)
            # content.pop(count)
          end
        end

        class Section # < Hashie::Mash
          attr_reader :parent, :header, :children, :content

          def initialize(parent, header)
            # puts "creating Section with header: #{header.inspect}"
            @parent   = parent
            @header   = header
            @children = []
            @content  = []
            parent.children << self
          end

          def inspect
            {}.tap do |h|
              h[:header] = header
              h[:content] = []
              content.each do |c|
                h[:content] << c
              end
            end
          end

          def <<(text)
            content << text
          end

          def rewind(count)
            content.pop(count)
          end
        end
      end
    end
  end
end

# Block-level calls
#
# If the return value of the method is nil, the block will be skipped. Therefore, make sure that your renderer has at least a paragraph method implemented. If the method for a document element is not implemented, the block will be skipped.
#
# Example:
#
# class RenderWithoutCode < Redcarpet::Render::HTML
#   def block_code(code, language)
#     nil
#   end
# end
# block_code(code, language)
# block_quote(quote)
# block_html(raw_html)
# footnotes(content)
# footnote_def(content, number)
# header(text, header_level)
# hrule()
# list(contents, list_type)
# list_item(text, list_type)
# paragraph(text)
# table(header, body)
# table_row(content)
# table_cell(content, alignment)
# Span-level calls
#
# A return value of nil will not output any data. If the method for a document element is not implemented, the contents of the span will be copied verbatim:
#
# autolink(link, link_type)
# codespan(code)
# double_emphasis(text)
# emphasis(text)
# image(link, title, alt_text)
# linebreak()
# link(link, title, content)
# raw_html(raw_html)
# triple_emphasis(text)
# strikethrough(text)
# superscript(text)
# underline(text)
# highlight(text)
# quote(text)
# footnote_ref(number)
# Note: When overriding a renderer's method, be sure to return a HTML element with a level that matches the level of that method (e.g. return a block element when overriding a block-level callback). Otherwise, the output may be unexpected.
#
# Low level rendering
#
# entity(text)
# normal_text(text)
# Header of the document
#
# Rendered before any another elements:
#
# doc_header()
# Footer of the document
#
# Rendered after all the other elements:
#
# doc_footer()
# Pre/post-process
#
# Special callback: preprocess or postprocess the whole document before or after the rendering process begins:
#
# preprocess(full_document)
# postprocess(full_document)
#
