require 'json'

module Support
  def io
    @io ||= HighLine.new
  end

  def json(object)
    JSON.pretty_generate(object)
  end

  def show(message, io = :stdout)
    output(/#{Regexp.escape(message.strip_heredoc)}/).send(:"to_#{io}")
  end
end
