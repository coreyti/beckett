module Beckett
  class Node::Codespan < Node::Text
    private

    def node_name
      'CODESPAN'
    end

    def node_type
      1
    end
  end
end
