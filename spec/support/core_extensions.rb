class String
  def strip_heredoc
    indent = (scan(/^[ \t]*(?=\S)/).min || '').size
    gsub(/^[ \t]{#{indent}}/, '')
  end
end
