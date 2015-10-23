require 'json'
require 'pp'

module Support
  RSpec::Matchers.define :render do |expected|
    match do |actual|
      @rendered  = json(Beckett::Document.new(actual).to_hash)
      @desired   = json(expected)
      @rendered == @desired
    end

    description do
      "render:\n#{@rendered}"
    end

    failure_message do |actual|
      differ   = RSpec::Support::Differ.new
      message  = "expected markdown to #{description}\n\nDiff:\n"
      message << differ.diff_as_string(@rendered, @desired)
    end
  end
end
