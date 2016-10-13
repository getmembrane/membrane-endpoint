class Api::V1::DocsController < ApplicationController
  include Swagger::PermissionTableHelper
  include Swagger::DescriptionHelper

  http_basic_authenticate_with(
    name:     "docs",
    password: "docs"
  )

  def index
    render
  end
end
