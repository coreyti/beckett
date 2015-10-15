require 'json'
require 'kramdown'

require 'wip/checklist/markdown/renderer'
require 'wip/checklist/markdown/node'
require 'wip/checklist/markdown/node/root'
require 'wip/checklist/markdown/node/element'
require 'wip/checklist/markdown/node/article'
require 'wip/checklist/markdown/node/section'
require 'wip/checklist/markdown/node/header'
require 'wip/checklist/markdown/node/text'

module WIP
  module Checklist
    module Markdown
      class Document
        def initialize(content)
          @content = content
        end

        def to_hash
          document = Kramdown::Document.new(@content)
          renderer = Renderer.send(:new, document.root)
          renderer.convert(document.root)
        end

        def to_json
          to_hash.to_json
        end
      end
    end
  end
end
