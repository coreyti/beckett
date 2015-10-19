module Beckett
  class Node::Root < Node::Base
    def to_h
      {
        root: {}.tap do |root|
          root[:children] = children.map(&:to_h)
        end
      }
    end
  end
end
