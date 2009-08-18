ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  msg   = instance.error_message
  title = msg.kind_of?(Array) ? msg.first : msg
  output = html_tag
  output << "\n<span class=\"validation_error\">#{title}</span>" unless html_tag.include?('label') or html_tag.include?('type="hidden"')
  output
end
