module Swagger::DescriptionHelper
  def description(content)
    ' \n #### Description \n ' + content
  end

  module_function :description
end
