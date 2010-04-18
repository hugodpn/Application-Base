class Admin::UsersController < ApplicationController
  def index
    permission_deny unless current_user.has_perm?("listing_users")
    @users = User.all
  end
end