require 'json'

module Support
  def debug
    puts rendered if debug?
  end

  def json(object)
    JSON.pretty_generate(object)
  end

  private

  def debug?
    ENV['DEBUG'] == 'true'
  end
end
