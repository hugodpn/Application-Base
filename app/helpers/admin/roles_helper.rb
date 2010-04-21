module Admin::RolesHelper

  def get_permission role, name
    permission = role.permissions.find_by_action(name)

    if permission and permission.granted == true
      "G"
    elsif  permission and permission.granted == false
      "D"
    else
      ""
    end
  end

end
