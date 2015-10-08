require 'spec_helper'

module WIP::Checklist
  module Markdown
    describe Document do
      let(:document) { Document.new(content) }
      let(:content)  { <<-CONTENT.strip_heredoc
          # Welcome to the checklist wiki!

          Intro text

          ## Section 1:

          - [ ] step one
          - [ ] step two

          ## Section 2:

          Content
        CONTENT
      }

      describe '#to_hash' do
        it 'renders the content as a Hash' do
          expect(document.to_hash).to eq({
            body: {
              node_name:  "ARTICLE",
              header:     "Welcome to the checklist wiki!",
              content:    ["Intro text"],
              children:   [
                {
                  node_name:  "SECTION",
                  header:     "Section 1:",
                  content:    ["[ ] step one\n", "[ ] step two\n"]
                },
                {
                  node_name:  "SECTION",
                  header:     "Section 2:",
                  content:    ["Content"]
                }
              ]
            }
          })
        end
      end
    end
  end
end
