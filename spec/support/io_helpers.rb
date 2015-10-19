require 'json'

module Support
  def debug
    puts rendered if debug?
  end

  def json(object)
    JSON.pretty_generate(object)
  end

  def show(message, io = :stdout)
    output(/#{Regexp.escape(message.strip_heredoc)}/).send(:"to_#{io}")
  end

  private

  def debug?
    ENV['DEBUG'] == 'true'
  end
end
