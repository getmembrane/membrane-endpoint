class Api::DocsController < ApplicationController
  http_basic_authenticate_with(
    name:     "docs",
    password: "docs"
  )

  layout "docs/layout"

  def index
  end

  def api
  end
end
