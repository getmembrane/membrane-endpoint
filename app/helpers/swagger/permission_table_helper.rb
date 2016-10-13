module Swagger::PermissionTableHelper
  module_function

  def basic_permission_table(permission_values)
    permissions_heading + thead_roles + basic_markdown_table_creator + \
      permission_values
  end

  def permission_table_with_adnotation(permission_values)
    permissions_heading + " | " + thead_roles + " | --- " + basic_markdown_table_creator + \
      permission_values
  end

  private

  def permissions_heading
    ' #### Permissions \n '
  end

  def thead_roles
    ' | Seller | Advertiser | Production Planner | Digital Planner | Not Logged In User | API Key\n '
  end

  def basic_markdown_table_creator
    ' | :-: | :-: | :-: | :-: | :-: | \n '
  end
end
