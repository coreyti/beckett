require 'spec_helper'

module Beckett
  describe Document do
    describe '#to_hash' do
      context 'given ...' do
        let(:content)  { <<-CONTENT.strip_heredoc
          CONTENT
        }

        it 'renders' do
          expect(content).to render({
            root: {
              children: []
            }
          })
        end
      end

      context 'given ...' do
        let(:content) { <<-CONTENT.strip_heredoc
            Paragraph 1

            Paragraph 2
          CONTENT
        }

        it 'renders' do
          expect(content).to render({
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
          })
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
          expect(content).to render({
            root: {
              children: [
                {
                  node_name:  'ARTICLE',
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
                  node_name:  'ARTICLE',
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
          })
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
          expect(content).to render({
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
                  node_name:  'ARTICLE',
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
          })
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
          expect(content).to render({
            root: {
              children: [
                {
                  node_name:  'ARTICLE',
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
                  node_name:  'ARTICLE',
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
          })
        end
      end

      context 'given ...' do
        let(:content) { <<-CONTENT.strip_heredoc
            - Item 1
            - Item 2
          CONTENT
        }

        it 'renders' do
          expect(content).to render({
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
          })
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
          expect(content).to render({
            root: {
              children:   [
                {
                  node_name:  'ARTICLE',
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
          })
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
          expect(content).to render({
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
          })
        end
      end

      context 'given ...' do
        let(:content) { <<-CONTENT.strip_heredoc
            Paragraph 1, Line 1
            Line 2, with `code`

            ```
            MESSAGE=LaLa
            echo $MESSAGE
            ```

            Paragraph 2
          CONTENT
        }

        it 'renders' do
          expect(content).to render({
            root: {
              children: [
                {
                  node_name: 'P',
                  node_type: 1,
                  children:  [
                    {
                      node_name: '#text',
                      node_type: 3,
                      node_text: 'Paragraph 1, Line 1'
                    },
                    {
                      node_name: 'BR',
                      node_type: 1
                    },
                    {
                      node_name: '#text',
                      node_type: 3,
                      node_text: "\nLine 2, with "
                    },
                    {
                      node_name: 'CODESPAN',
                      node_type: 1,
                      node_text: 'code'
                    }
                  ]
                },
                {
                  node_name: 'CODEBLOCK',
                  node_type: 1,
                  node_text: "MESSAGE=LaLa\necho $MESSAGE"
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
        let(:content) { <<-CONTENT.strip_heredoc
            Paragraph 1 *with* emphasis
          CONTENT
        }

        it 'renders' do
          expect(content).to render({
            root: {
              children: [
                {
                  node_name: 'P',
                  node_type: 1,
                  children:  [
                    {
                      node_name: '#text',
                      node_type: 3,
                      node_text: 'Paragraph 1 '
                    },
                    {
                      node_name: 'EM',
                      node_type: 1,
                      children:  [
                        {
                          node_name: '#text',
                          node_type: 3,
                          node_text: 'with'
                        }
                      ]
                    },
                    {
                      node_name: '#text',
                      node_type: 3,
                      node_text: ' emphasis'
                    }
                  ]
                }
              ]
            }
          })
        end
      end

      context 'given ...' do
        let(:content) { <<-CONTENT.strip_heredoc
            > from: <http://example.com>,
            >
            > multi-
            > line
            >
            > block
            > quote with [a link](http://example.com).
          CONTENT
        }

        it 'renders' do
          expect(content).to render({
            root: {
              children: [
                {
                  node_name: 'BLOCKQUOTE',
                  node_type: 1,
                  children:  [
                    {
                      node_name: 'P',
                      node_type: 1,
                      children:  [
                        {
                          node_name: '#text',
                          node_type: 3,
                          node_text: 'from: '
                        },
                        {
                          node_name: 'A',
                          node_type: 1,
                          attributes: {
                            href: 'http://example.com'
                          },
                          children:  [
                            {
                              node_name: '#text',
                              node_type: 3,
                              node_text: 'http://example.com'
                            },
                          ]
                        },
                        {
                          node_name: '#text',
                          node_type: 3,
                          node_text: ','
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
                          node_text: 'multi-'
                        },
                        {
                          node_name: 'BR',
                          node_type: 1
                        },
                        {
                          node_name: '#text',
                          node_type: 3,
                          node_text: "\nline"
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
                          node_text: 'block'
                        },
                        {
                          node_name: 'BR',
                          node_type: 1
                        },
                        {
                          node_name: '#text',
                          node_type: 3,
                          node_text: "\nquote with "
                        },
                        {
                          node_name: 'A',
                          node_type: 1,
                          attributes: {
                            href: 'http://example.com'
                          },
                          children:  [
                            {
                              node_name: '#text',
                              node_type: 3,
                              node_text: 'a link'
                            },
                          ]
                        },
                        {
                          node_name: '#text',
                          node_type: 3,
                          node_text: '.'
                        }
                      ]
                    }
                  ]
                }
              ]
            }
          })
        end
      end

      context 'given ...' do
        let(:content) { <<-CONTENT.strip_heredoc
          |------------+------------|
          | Header A   | Header B   |
          |------------|------------|
          | Content A1 | Content B1 |
          | Content A2 | Content B2 |
          |------------+------------|
          CONTENT
        }

        it 'renders' do
          expect(content).to render({
            root: {
              children: [
                {
                  node_name: 'TABLE',
                  node_type: 1,
                  children:  [
                    {
                      node_name: 'THEAD',
                      node_type: 1,
                      children:  [
                        {
                          node_name: 'TR',
                          node_type: 1,
                          children:  [
                            {
                              node_name: 'TD',
                              node_type: 1,
                              children:  [
                                {
                                  node_name: '#text',
                                  node_type: 3,
                                  node_text: 'Header A'
                                }
                              ]
                            },
                            {
                              node_name: 'TD',
                              node_type: 1,
                              children:  [
                                {
                                  node_name: '#text',
                                  node_type: 3,
                                  node_text: 'Header B'
                                }
                              ]
                            }
                          ]
                        }
                      ]
                    },
                    {
                      node_name: 'TBODY',
                      node_type: 1,
                      children:  [
                        {
                          node_name: 'TR',
                          node_type: 1,
                          children:  [
                            {
                              node_name: 'TD',
                              node_type: 1,
                              children:  [
                                {
                                  node_name: '#text',
                                  node_type: 3,
                                  node_text: 'Content A1'
                                }
                              ]
                            },
                            {
                              node_name: 'TD',
                              node_type: 1,
                              children:  [
                                {
                                  node_name: '#text',
                                  node_type: 3,
                                  node_text: 'Content B1'
                                }
                              ]
                            }
                          ]
                        },
                        {
                          node_name: 'TR',
                          node_type: 1,
                          children:  [
                            {
                              node_name: 'TD',
                              node_type: 1,
                              children:  [
                                {
                                  node_name: '#text',
                                  node_type: 3,
                                  node_text: 'Content A2'
                                }
                              ]
                            },
                            {
                              node_name: 'TD',
                              node_type: 1,
                              children:  [
                                {
                                  node_name: '#text',
                                  node_type: 3,
                                  node_text: 'Content B2'
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
          })
        end
      end

      context 'given ...' do
        let(:content) { <<-CONTENT.strip_heredoc
            *Text A1*
            _Text A2_
            **Text B1**
            __Text B2__
          CONTENT
        }

        it 'renders' do
          expect(content).to render({
            root: {
              children: [
                {
                  node_name: 'P',
                  node_type: 1,
                  children:  [
                    {
                      node_name: 'EM',
                      node_type: 1,
                      children:  [
                        {
                          node_name: '#text',
                          node_type: 3,
                          node_text: 'Text A1'
                        }
                      ]
                    },
                    {
                      node_name: 'BR',
                      node_type: 1,
                    },
                    {
                      node_name: 'EM',
                      node_type: 1,
                      children:  [
                        {
                          node_name: '#text',
                          node_type: 3,
                          node_text: 'Text A2'
                        }
                      ]
                    },
                    {
                      node_name: 'BR',
                      node_type: 1,
                    },
                    {
                      node_name: 'STRONG',
                      node_type: 1,
                      children:  [
                        {
                          node_name: '#text',
                          node_type: 3,
                          node_text: 'Text B1'
                        }
                      ]
                    },
                    {
                      node_name: 'BR',
                      node_type: 1,
                    },
                    {
                      node_name: 'STRONG',
                      node_type: 1,
                      children:  [
                        {
                          node_name: '#text',
                          node_type: 3,
                          node_text: 'Text B2'
                        }
                      ]
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
