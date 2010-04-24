class UserSession < Authlogic::Session::Base

  def validate_by_password
    # grab the user, this actually happens again so it is
    # redundant, though the overhead shouldn't be too high
    user = search_for_record(find_by_login_method, send(login_field))

    # this is the field indicating if the user should be allowed to login
    unless user.is_enabled
      # user is not allowed to login, add an error telling the user they are not allowed
      errors.add_to_base "Sorry, login has been disabled for your account"
      return
    end

    # user is allowed to login, call the normal base class method in
    # AuthLogic::Session::Password to actually validate the user's login
    super
  end

end