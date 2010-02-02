module Tefter
  class FormBuilder < Formtastic::SemanticFormBuilder
    def error_messages(options = {})
      options[:header_tag] = :h3
      options[:id] = ""
      options[:class] = "errors"
      options[:header_message] = "Something did not quite work out here."
      options[:message] = ""
      super(options)
    end
  end
end
