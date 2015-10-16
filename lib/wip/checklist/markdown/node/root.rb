module WIP
  module Checklist
    module Markdown
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
  end
end
