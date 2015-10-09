require 'spec_helper'

module WIP::Checklist
  module Markdown
    describe Document do
      let(:document) { Document.new(content) }

      describe '#to_hash' do
        context 'given ...' do
          let(:content)  { <<-CONTENT.strip_heredoc
            CONTENT
          }

          it 'renders' do
            expect(document.to_hash).to eq({
              body: {
                node_name:  "ARTICLE",
                node_type:  1
              }
            })
          end
        end

        context 'given ...' do
          let(:content)  { <<-CONTENT.strip_heredoc
              Paragraph
            CONTENT
          }

          it 'renders' do
            expect(document.to_hash).to eq({
              body: {
                node_name:  "ARTICLE",
                node_type:  1,
                children:   [
                  {
                    node_name: 'P',
                    node_type: 1,
                    children:  [
                      {
                        node_name: '#text',
                        node_type: 3,
                        node_text: 'Paragraph'
                      }
                    ]
                  }
                ]
              }
            })
          end
        end

        context 'given ...' do
          let(:content)  { <<-CONTENT.strip_heredoc
              Paragraph 1

              Paragraph 2
            CONTENT
          }

          it 'renders' do
            expect(document.to_hash).to eq({
              body: {
                node_name:  "ARTICLE",
                node_type:  1,
                children:   [
                  {
                    node_name: 'P',
                    node_type: 1,
                    children:  [
                      {
                        node_name: '#text',
                        node_type: 3,
                        node_text: 'Paragraph 1'
                      }
                    ]
                  },
                  {
                    node_name: 'P',
                    node_type: 1,
                    children:  [
                      {
                        node_name: '#text',
                        node_type: 3,
                        node_text: 'Paragraph 2'
                      }
                    ]
                  }
                ]
              }
            })
          end
        end

        context 'given ...' do
          let(:content)  { <<-CONTENT.strip_heredoc
              # Header

              Paragraph 1

              Paragraph 2
            CONTENT
          }

          it 'renders' do
            expect(document.to_hash).to eq({
              body: {
                node_name:  "ARTICLE",
                node_type:  1,
                header:     "Header",
                children:   [
                  {
                    node_name: 'P',
                    node_type: 1,
                    children:  [
                      {
                        node_name: '#text',
                        node_type: 3,
                        node_text: 'Paragraph 1'
                      }
                    ]
                  },
                  {
                    node_name: 'P',
                    node_type: 1,
                    children:  [
                      {
                        node_name: '#text',
                        node_type: 3,
                        node_text: 'Paragraph 2'
                      }
                    ]
                  }
                ]
              }
            })
          end
        end
      end
    end
  end
end

        # expect(document.to_hash).to eq({
        #   children: [
        #     {
        #       node_name: 'ARTICLE', # thereby allowing mulitple articles in a single document
        #       # node_text: "
        #       #   # Welcome to the checklist wiki!
        #       #
        #       #   Intro text
        #       #
        #       #   ## Section 1:
        #       #   ...
        #       # ",
        #       children: [
        #         {
        #           node_name: 'H1',
        #           node_text: 'Welcome to the checklist wiki!'
        #         },
        #         {
        #           node_name: 'P',
        #           node_text: 'Intro text'
        #         },
        #         {
        #           node_name: 'SECTION',
        #           # node_text: "
        #           #   ## Section 1:
        #           #
        #           #   - [ ] step one
        #           #   - [ ] step two
        #           #   ...
        #           # ",
        #           children: [
