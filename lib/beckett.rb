require 'json'
require 'kramdown'
require 'kramdown/parser/gfm'

require 'beckett/renderer'
require 'beckett/node'
require 'beckett/node/root'

require 'beckett/node/element'
require 'beckett/node/article'
require 'beckett/node/section'
require 'beckett/node/header'
require 'beckett/node/codeblock'

require 'beckett/node/text'
require 'beckett/node/codespan'
require 'beckett/node/br'


module Beckett
  class Document
    def initialize(content)
      @document = Kramdown::Document.new(content, input: 'GFM')
    end

    def to_hash
      renderer = Renderer.send(:new, @document.root)
      renderer.convert(@document.root)
    end

    def to_html
      @document.to_html
    end

    def to_json
      to_hash.to_json
    end
  end
end
