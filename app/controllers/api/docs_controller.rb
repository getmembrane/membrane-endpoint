class API::DocsController < ApplicationController
  http_basic_authenticate_with(
    name:     ENV["DOCUMENTATION_HTTP_BASIC_AUTH_USER"],
    password: ENV["DOCUMENTATION_HTTP_BASIC_AUTH_PASSWORD"]
  )

  layout "docs/layout"

  def index
  end

  def api
  end

  def changelog
    text = IO.read(File.join(Rails.root, "CHANGELOG.md"))
    @changelog_content = Kramdown::Document.new(text).to_html.html_safe
  end
end
