require 'spec_helper'

module WIP::Checklist
  module Markdown
    describe Document do
      let(:document) { Document.new(content) }

      describe '#to_hash' do
        let(:rendered) { json(document.to_hash) }

        context 'given ...' do
          let(:content)  { <<-CONTENT.strip_heredoc
            CONTENT
          }

          it 'renders' do
            expect(rendered).to eq(json({
              root: {
                children: []
              }
            }))
          end
        end

        context 'given...' do
          let(:content) { <<-CONTENT.strip_heredoc
              Paragraph 1

              Paragraph 2
            CONTENT
          }

          it 'renders' do
            expect(rendered).to eq(json({
              root: {
                children: [
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
            }))
          end
        end

        context 'given ...' do
          let(:content) { <<-CONTENT.strip_heredoc
              # Article A

              Paragraph A1

              # Article B

              Paragraph B1
            CONTENT
          }

          it 'renders' do
            expect(rendered).to eq(json({
              root: {
                children: [
                  {
                    node_name:  "ARTICLE",
                    node_type:  1,
                    children:   [
                      {
                        node_name: 'HEADER',
                        node_type: 1,
                        children:  [
                          {
                            node_name: '#text',
                            node_type: 3,
                            node_text: 'Article A'
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
                            node_text: 'Paragraph A1'
                          }
                        ]
                      }
                    ]
                  },
                  {
                    node_name:  "ARTICLE",
                    node_type:  1,
                    children:   [
                      {
                        node_name: 'HEADER',
                        node_type: 1,
                        children:  [
                          {
                            node_name: '#text',
                            node_type: 3,
                            node_text: 'Article B'
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
                            node_text: 'Paragraph B1'
                          }
                        ]
                      }
                    ]
                  }
                ]
              }
            }))
          end
        end

        context 'given...' do
          let(:content) { <<-CONTENT.strip_heredoc
              Paragraph 1

              # Article A

              Paragraph A1

              Paragraph A2
            CONTENT
          }

          it 'renders' do
            expect(rendered).to eq(json({
              root: {
                children: [
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
                    node_name:  "ARTICLE",
                    node_type:  1,
                    children:   [
                      {
                        node_name: 'HEADER',
                        node_type: 1,
                        children:  [
                          {
                            node_name: '#text',
                            node_type: 3,
                            node_text: 'Article A'
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
                            node_text: 'Paragraph A1'
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
                            node_text: 'Paragraph A2'
                          }
                        ]
                      }
                    ]
                  },
                ]
              }
            }))
          end
        end

        context 'given ...' do
          let(:content)  { <<-CONTENT.strip_heredoc
              # Article A

              ## Section AA

              Paragraph AA.1

              ## Section AB

              ### Section ABA

              Paragraph ABA.1

              # Article B

              Paragraph B.1
            CONTENT
          }

          it 'renders' do
            expect(rendered).to eq(json({
              root: {
                children: [
                  {
                    node_name:  "ARTICLE",
                    node_type:  1,
                    children:   [
                      {
                        node_name: 'HEADER',
                        node_type: 1,
                        children:  [
                          {
                            node_name: '#text',
                            node_type: 3,
                            node_text: 'Article A'
                          }
                        ]
                      },
                      {
                        node_name: 'SECTION',
                        node_type: 1,
                        children:  [
                          {
                            node_name: 'HEADER',
                            node_type: 1,
                            children:  [
                              {
                                node_name: '#text',
                                node_type: 3,
                                node_text: 'Section AA'
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
                                node_text: 'Paragraph AA.1'
                              }
                            ]
                          }
                        ]
                      },
                      {
                        node_name: 'SECTION',
                        node_type: 1,
                        children:  [
                          {
                            node_name: 'HEADER',
                            node_type: 1,
                            children:  [
                              {
                                node_name: '#text',
                                node_type: 3,
                                node_text: 'Section AB'
                              }
                            ]
                          },
                          {
                            node_name: 'SECTION',
                            node_type: 1,
                            children:  [
                              {
                                node_name: 'HEADER',
                                node_type: 1,
                                children:  [
                                  {
                                    node_name: '#text',
                                    node_type: 3,
                                    node_text: 'Section ABA'
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
                                    node_text: 'Paragraph ABA.1'
                                  }
                                ]
                              }
                            ]
                          }
                        ]
                      },
                    ]
                  },
                  {
                    node_name:  "ARTICLE",
                    node_type:  1,
                    children:   [
                      {
                        node_name: 'HEADER',
                        node_type: 1,
                        children:  [
                          {
                            node_name: '#text',
                            node_type: 3,
                            node_text: 'Article B'
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
                            node_text: 'Paragraph B.1'
                          }
                        ]
                      }
                    ]
                  }
                ]
              }
            }))
          end
        end

        xcontext 'given ...' do
          let(:content)  { <<-CONTENT.strip_heredoc
              # Header

              ## Section 1

              Paragraph 1A

              - List Item 1A
              - List Item 1B

              Paragraph 1B

              ## Section 2

              Paragraph 2A

              ### Section 2I

              Paragraph 2IA

              - List Item 2IA
                1. List Item 2IA1
                2. List Item 2IA2
              - List Item 2IB
                - List Item 2IB1
                - List Item 2IB2

              ## Section 3

              Paragraph 3A
            CONTENT
          }

          it 'renders' do
            expect(document.to_json).to eq({
              body: {
                node_name:  "ARTICLE",
                node_type:  1,
                header:     "Header",
                children:   [
                  {
                    node_name: 'SECTION',
                    node_type: 1,
                    header:    "Section 1",
                    children:  [
                      {
                        node_name: 'P',
                        node_type: 1,
                        children:  [
                          {
                            node_name: '#text',
                            node_type: 3,
                            node_text: 'Paragraph 1A'
                          }
                        ]
                      },
                      {
                        node_name: 'UL',
                        node_type: 1,
                        children:  [
                          {
                            node_name: 'LI',
                            node_type: 1,
                            children:  [
                              {
                                node_name: '#text',
                                node_type: 3,
                                node_text: 'List Item 1A'
                              }
                            ]
                          },
                          {
                            node_name: 'LI',
                            node_type: 1,
                            children:  [
                              {
                                node_name: '#text',
                                node_type: 3,
                                node_text: 'List Item 1B'
                              }
                            ]
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
                            node_text: 'Paragraph 1B'
                          }
                        ]
                      }
                    ]
                  },
                  {
                    node_name: 'SECTION',
                    node_type: 1,
                    header:    "Section 2",
                    children:  [
                      {
                        node_name: 'P',
                        node_type: 1,
                        children:  [
                          {
                            node_name: '#text',
                            node_type: 3,
                            node_text: 'Paragraph 2A'
                          }
                        ]
                      },
                      {
                        node_name: 'SECTION',
                        node_type: 1,
                        header:    "Section 2I",
                        children:  [
                          {
                            node_name: 'P',
                            node_type: 1,
                            children:  [
                              {
                                node_name: '#text',
                                node_type: 3,
                                node_text: 'Paragraph 2IA'
                              }
                            ]
                          },
                          {
                            node_name: 'UL',
                            node_type: 1,
                            children:  [
                              {
                                node_name: 'LI',
                                node_type: 1,
                                children:  [
                                  {
                                    node_name: '#text',
                                    node_type: 1,
                                    node_text: 'List Item 2IA'
                                  },
                                  {
                                    node_name: 'OL',
                                    node_type: 1,
                                    children:  [
                                      {
                                        node_name: 'LI',
                                        node_type: 1,
                                        children:  [
                                          {
                                            node_name: '#text',
                                            node_type: 3,
                                            node_text: 'List Item 2IA1'
                                          }
                                        ]
                                      },
                                      {
                                        node_name: 'LI',
                                        node_type: 1,
                                        children:  [
                                          {
                                            node_name: '#text',
                                            node_type: 3,
                                            node_text: 'List Item 2IA2'
                                          }
                                        ]
                                      }
                                    ]
                                  }
                                ]
                              },
                              {
                                node_name: 'LI',
                                node_type: 1,
                                children:  [
                                  {
                                    node_name: '#text',
                                    node_type: 1,
                                    node_text: 'List Item 2IB'
                                  },
                                  {
                                    node_name: 'UL',
                                    node_type: 1,
                                    children:  [
                                      {
                                        node_name: 'LI',
                                        node_type: 1,
                                        children:  [
                                          {
                                            node_name: '#text',
                                            node_type: 3,
                                            node_text: 'List Item 2IB1'
                                          }
                                        ]
                                      },
                                      {
                                        node_name: 'LI',
                                        node_type: 1,
                                        children:  [
                                          {
                                            node_name: '#text',
                                            node_type: 3,
                                            node_text: 'List Item 2IB2'
                                          }
                                        ]
                                      }
                                    ]
                                  }
                                ]
                              }
                            ]
                          }
                        ]
                      }
                    ]
                  },
                  {
                    node_name: 'SECTION',
                    node_type: 1,
                    header:    "Section 3",
                    children:  [
                      {
                        node_name: 'P',
                        node_type: 1,
                        children:  [
                          {
                            node_name: '#text',
                            node_type: 3,
                            node_text: 'Paragraph 3A'
                          }
                        ]
                      }
                    ]
                  }
                ]
              }
            }.to_json)
          end
        end

        xcontext 'given ...' do
          let(:content) { <<-CONTENT.strip_heredoc
              # Header

              - List Item A1
                - List Item A1A
                - List Item A1B
              - List Item A2
                1. List Item A2A
                2. List Item A2B
              - List Item A3
                - List Item A2A
                - List Item A2B
            CONTENT
          }

          it 'renders' do
            expect(json(document.to_hash)).to eq(json({
              body: {
                node_name:  "ARTICLE",
                node_type:  1,
                children:   [
                  {
                    node_name: 'HEADER',
                    node_type: 1,
                    children:  [
                      {
                        node_name: '#text',
                        node_type: 3,
                        node_text: 'Header'
                      }
                    ]
                  },
                  {
                    node_name: 'UL',
                    node_type: 1,
                    children:  [
                      {
                        node_name: 'LI',
                        node_type: 1,
                        children:  [
                          {
                            node_name: '#text',
                            node_type: 3,
                            node_text: 'List Item A1'
                          },
                          {
                            node_name: 'UL',
                            node_type: 1,
                            children:  [
                              {
                                node_name: 'LI',
                                node_type: 1,
                                children:  [
                                  {
                                    node_name: '#text',
                                    node_type: 3,
                                    node_text: 'List Item A1A'
                                  }
                                ]
                              },
                              {
                                node_name: 'LI',
                                node_type: 1,
                                children:  [
                                  {
                                    node_name: '#text',
                                    node_type: 3,
                                    node_text: 'List Item A1B'
                                  }
                                ]
                              }
                            ]
                          }
                        ]
                      },
                      {
                        node_name: 'LI',
                        node_type: 1,
                        children:  [
                          {
                            node_name: '#text',
                            node_type: 3,
                            node_text: 'List Item A2'
                          },
                          {
                            node_name: 'UL',
                            node_type: 1,
                            children:  [
                              {
                                node_name: 'LI',
                                node_type: 1,
                                children:  [
                                  {
                                    node_name: '#text',
                                    node_type: 3,
                                    node_text: 'List Item A2A'
                                  }
                                ]
                              },
                              {
                                node_name: 'LI',
                                node_type: 1,
                                children:  [
                                  {
                                    node_name: '#text',
                                    node_type: 3,
                                    node_text: 'List Item A2B'
                                  }
                                ]
                              }
                            ]
                          }
                        ]
                      }
                    ]
                  }
                ]
              }
            }))
          end
        end
      end
    end
  end
end
