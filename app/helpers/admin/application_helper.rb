module Admin::ApplicationHelper
  def roles
    # {
    #   'Manager' => 'manager',
    #   'Editor' => 'editor',
    #   'Viewer' => 'viewer'
    # }
    hash = {}
    Role.available_roles.each do |role|
      hash[role.titleize] = role
    end
    hash
  end
end
