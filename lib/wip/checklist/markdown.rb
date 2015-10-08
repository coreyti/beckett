require 'wip/checklist/markdown/renderer'

# content  = File.read('/tmp/checklists/checklist.wiki/Home.md')
# document = WIP::Checklist::Markdown::Document.new(content)
# document.to_hash
module WIP
  module Checklist
    module Markdown
      class Document
        def initialize(content)
          @content = content
        end

        def to_hash
          Redcarpet::Markdown.new(Renderer.new)
            .render(@content)
        end
      end
    end
  end
end
