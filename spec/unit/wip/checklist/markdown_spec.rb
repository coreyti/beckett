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
            debug
            expect(rendered).to eq(json({
              root: {
                children: []
              }
            }))
          end
        end

        context 'given ...' do
          let(:content) { <<-CONTENT.strip_heredoc
              Paragraph 1

              Paragraph 2
            CONTENT
          }

          it 'renders' do
            debug
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
            debug
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

        context 'given ...' do
          let(:content) { <<-CONTENT.strip_heredoc
              Paragraph 1

              # Article A

              Paragraph A1

              Paragraph A2
            CONTENT
          }

          it 'renders' do
            debug
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
            debug
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

        context 'given ...' do
          let(:content) { <<-CONTENT.strip_heredoc
              - Item 1
              - Item 2
            CONTENT
          }

          it 'renders' do
            debug
            expect(rendered).to eq(json({
              root: {
                children:   [
                  {
                    node_name: 'UL',
                    node_type: 1,
                    children:  [
                      {
                        node_name: 'LI',
                        node_type: 1,
                        children:  [
                          {
                            node_name: 'P',
                            node_type: 1,
                            children: [
                              {
                                node_name: '#text',
                                node_type: 3,
                                node_text: 'Item 1'
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
                            node_name: 'P',
                            node_type: 1,
                            children: [
                              {
                                node_name: '#text',
                                node_type: 3,
                                node_text: 'Item 2'
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

        context 'given ...' do
          let(:content) { <<-CONTENT.strip_heredoc
              # Article A

              - Item A.1
                - Item A.1.1
                - Item A.1.2
              - Item A.2
                1. Item A.2.1
                2. Item A.2.2
              - Item A.3
                - Item A.3.1
                - Item A.3.2
            CONTENT
          }

          it 'renders' do
            debug
            expect(rendered).to eq(json({
              root: {
                children:   [
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
                        node_name: 'UL',
                        node_type: 1,
                        children:  [
                          {
                            node_name: 'LI',
                            node_type: 1,
                            children:  [
                              {
                                node_name: 'P',
                                node_type: 1,
                                children:  [
                                  {
                                    node_name: '#text',
                                    node_type: 3,
                                    node_text: 'Item A.1'
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
                                        node_name: 'P',
                                        node_type: 1,
                                        children:  [
                                          {
                                            node_name: '#text',
                                            node_type: 3,
                                            node_text: 'Item A.1.1'
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
                                        node_name: 'P',
                                        node_type: 1,
                                        children:  [
                                          {
                                            node_name: '#text',
                                            node_type: 3,
                                            node_text: 'Item A.1.2'
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
                            node_name: 'LI',
                            node_type: 1,
                            children:  [
                              {
                                node_name: 'P',
                                node_type: 1,
                                children:  [
                                  {
                                    node_name: '#text',
                                    node_type: 3,
                                    node_text: 'Item A.2'
                                  }
                                ]
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
                                        node_name: 'P',
                                        node_type: 1,
                                        children:  [
                                          {
                                            node_name: '#text',
                                            node_type: 3,
                                            node_text: 'Item A.2.1'
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
                                        node_name: 'P',
                                        node_type: 1,
                                        children:  [
                                          {
                                            node_name: '#text',
                                            node_type: 3,
                                            node_text: 'Item A.2.2'
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
                            node_name: 'LI',
                            node_type: 1,
                            children:  [
                              {
                                node_name: 'P',
                                node_type: 1,
                                children:  [
                                  {
                                    node_name: '#text',
                                    node_type: 3,
                                    node_text: 'Item A.3'
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
                                        node_name: 'P',
                                        node_type: 1,
                                        children:  [
                                          {
                                            node_name: '#text',
                                            node_type: 3,
                                            node_text: 'Item A.3.1'
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
                                        node_name: 'P',
                                        node_type: 1,
                                        children:  [
                                          {
                                            node_name: '#text',
                                            node_type: 3,
                                            node_text: 'Item A.3.2'
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
                  }
                ]
              }
            }))
          end
        end

        context 'given ...' do
          let(:content)  { <<-CONTENT.strip_heredoc
              - Item 1

                  Term A
                  : Definition A

                    - Item A.1
                    - Item A.2

                  Term B
                  : Definition B

                  - Item 1.1
                  - Item 1.2
              - Item 2
            CONTENT
          }

          it 'renders' do
            debug
            expect(rendered).to eq(json({
              root: {
                children: [
                  {
                    node_name: 'UL',
                    node_type: 1,
                    children: [
                      {
                        node_name: 'LI',
                        node_type: 1,
                        children: [
                          {
                            node_name: 'P',
                            node_type: 1,
                            children: [
                              {
                                node_name: '#text',
                                node_type: 3,
                                node_text: 'Item 1'
                              }
                            ]
                          },
                          {
                            node_name: 'DL',
                            node_type: 1,
                            children: [
                              {
                                node_name: 'DT',
                                node_type: 1,
                                children: [
                                  {
                                    node_name: '#text',
                                    node_type: 3,
                                    node_text: 'Term A'
                                  }
                                ]
                              },
                              {
                                node_name: 'DD',
                                node_type: 1,
                                children: [
                                  {
                                    node_name: 'P',
                                    node_type: 1,
                                    children: [
                                      {
                                        node_name: '#text',
                                        node_type: 3,
                                        node_text: 'Definition A'
                                      }
                                    ]
                                  },
                                  {
                                    node_name: 'UL',
                                    node_type: 1,
                                    children: [
                                      {
                                        node_name: 'LI',
                                        node_type: 1,
                                        children: [
                                          {
                                            node_name: 'P',
                                            node_type: 1,
                                            children: [
                                              {
                                                node_name: '#text',
                                                node_type: 3,
                                                node_text: 'Item A.1'
                                              }
                                            ]
                                          }
                                        ]
                                      },
                                      {
                                        node_name: 'LI',
                                        node_type: 1,
                                        children: [
                                          {
                                            node_name: 'P',
                                            node_type: 1,
                                            children: [
                                              {
                                                node_name: '#text',
                                                node_type: 3,
                                                node_text: 'Item A.2'
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
                                node_name: 'DT',
                                node_type: 1,
                                children: [
                                  {
                                    node_name: '#text',
                                    node_type: 3,
                                    node_text: 'Term B'
                                  }
                                ]
                              },
                              {
                                node_name: 'DD',
                                node_type: 1,
                                children: [
                                  {
                                    node_name: 'P',
                                    node_type: 1,
                                    children: [
                                      {
                                        node_name: '#text',
                                        node_type: 3,
                                        node_text: 'Definition B'
                                      }
                                    ]
                                  }
                                ]
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
                                    node_name: 'P',
                                    node_type: 1,
                                    children:  [
                                      {
                                        node_name: '#text',
                                        node_type: 3,
                                        node_text: 'Item 1.1'
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
                                    node_name: 'P',
                                    node_type: 1,
                                    children:  [
                                      {
                                        node_name: '#text',
                                        node_type: 3,
                                        node_text: 'Item 1.2'
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
                        node_name: 'LI',
                        node_type: 1,
                        children: [
                          {
                            node_name: 'P',
                            node_type: 1,
                            children: [
                              {
                                node_name: '#text',
                                node_type: 3,
                                node_text: 'Item 2'
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
