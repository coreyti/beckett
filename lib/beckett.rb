require 'json'
require 'kramdown'

require 'beckett/renderer'
require 'beckett/node'
require 'beckett/node/root'

require 'beckett/node/element'
require 'beckett/node/article'
require 'beckett/node/section'
require 'beckett/node/header'

require 'beckett/node/text'
require 'beckett/node/codespan'

module Beckett
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
