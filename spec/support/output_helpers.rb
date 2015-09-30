module Support
  def show(message, io = :stdout)
    output(/#{Regexp.escape(message)}/).send(:"to_#{io}")
  end
end
