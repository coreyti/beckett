require 'spec_helper'

module Beckett
  describe Node::Codeblock do
    describe '#to_hash' do
      context 'given GFM-style fenced code with an IAL' do
        let(:content) { <<-CONTENT.strip_heredoc
            {: attribute="value" }
            ```yaml
            ---
            key: value
            ```

          CONTENT
        }

        it 'renders' do
          expect(content).to render({
            root: {
              children: [
                {
                  node_name: "CODEBLOCK",
                  node_type: 1,
                  attributes: {
                    class: "language-yaml",
                    attribute: "value"
                  },
                  node_text: "---\nkey: value"
                }
              ]
            }
          })
        end
      end
    end
  end
end
