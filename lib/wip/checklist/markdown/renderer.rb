require 'redcarpet'

module WIP
  module Checklist
    module Markdown
      class Renderer < Redcarpet::Render::Base
        attr_reader :context #, :article, :result

        def initialize
          @article = Node::Article.new(nil)
          @context = @article
          super
        end

        def to_h
          { body: @article.to_h }
        end

        # markdown blocks
        # --------------------------------------------------
        # block_code(code, language)          # special? indent-specific
        # block_quote(quote)                  # special? indent-specific
        # block_html(raw_html)                # special? indent-specific
        # footnotes(content)                  #
        # footnote_def(content, number)       #
        # header(text, header_level)          # special. section in/out.
        # hrule()                             #
        # list(contents, list_type)           # no sub-block, except LI
        # list_item(text, list_type)          #
        # paragraph(text)
        # table(header, body)
        # table_row(content)
        # table_cell(content, alignment)

        def header(text, level)
          if level == 1
            @context.header = text
          else
            while( ! @context.allow?('SECTION', level))
              @context = @context.parent
            end

            @context = @context.section(text, level)
          end

          nil
        end

        def paragraph(text)
          while( ! @context.allow?('P'))
            @context = @context.parent
          end

          # @context = @context.section(text, level)
          @context.paragraph(text)
          nil
        end


        # markdown spans
        # --------------------------------------------------
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


        # markdown low-level
        # --------------------------------------------------
        # doc_header()
        # doc_footer()
        # entity(text)
        # normal_text(text)


        # markdown pre-/post-processing
        # --------------------------------------------------
        # preprocess
        # postprocess

        def postprocess(*)
          to_h
        end
      end
    end
  end
end
