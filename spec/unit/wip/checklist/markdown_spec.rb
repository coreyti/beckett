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
          - [ ] step 3
          - [ ] step 4
          - [ ] step 5

          ## Section 2:

          content
        CONTENT
      }

      describe '#to_hash' do
        it 'renders the content as a Hash' do
          expect(document.to_hash).to eq({
            :children => [
              {
                :header=>"Welcome to the checklist wiki!",
                :content=>["Intro text"]
              },
              {
                :header=>"Section 1:",
                :content=>["[ ] step one\n", "[ ] step two\n", "[ ] step 3\n", "[ ] step 4\n", "[ ] step 5\n"]
              },
              {
                :header=>"Section 2:",
                :content=>["content"]
              }
            ]
          })
        end
      end
    end
  end
end
