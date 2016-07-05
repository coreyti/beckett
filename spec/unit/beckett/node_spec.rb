require 'spec_helper'

module Beckett
  describe Node do
    describe '#to_hash' do
      context 'given an inline attribute list (IAL)' do
        let(:content) { <<-CONTENT.strip_heredoc
            {: attribute="value" }
            Content

          CONTENT
        }

        it 'renders' do
          expect(content).to render({
            root: {
              children: [
                {
                  node_name: "P",
                  node_type: 1,
                  attributes: {
                    attribute: "value"
                  },
                  children: [
                    {
                      node_name: "#text",
                      node_type: 3,
                      node_text: "Content"
                    }
                  ]
                }
              ]
            }
          })
        end
      end

      context 'given an inline attribute list (IAL) postfixed to a DL' do
        # let(:content) { <<-CONTENT.strip_heredoc
        #     Term 1
        #     : Description
        #
        #     Term 2
        #     : Description
        #     {: data-schema="https://schema.wip.sh/PropertyList" }
        #   CONTENT
        # }

        # let(:content) { <<-CONTENT.strip_heredoc
        #     {::properties}
        #
        #     ACCESS-KEY-ID
        #     : Description of `ACCESS-KEY-ID`
        #     : `required`
        #     : `default: bogus`
        #
        #     SECRET-ACCESS-KEY
        #     : Description of `SECRET-ACCESS-KEY`
        #
        #     {:/properties}
        #   CONTENT
        # }

        let(:content) { <<-CONTENT.strip_heredoc
            ACCESS-KEY-ID
            : {: required="true" default="bogus" }
              Description of `ACCESS-KEY-ID`

            SECRET-ACCESS-KEY
            : Description of `SECRET-ACCESS-KEY`
              {: required="true" default="bogus" }
          CONTENT
        }

        it 'renders' do
          expect(content).to render({
            root: {
              children: [
                {
                  node_name: "P",
                  node_type: 1,
                  attributes: {
                    attribute: "value"
                  },
                  children: [
                    {
                      node_name: "#text",
                      node_type: 3,
                      node_text: "Content"
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
