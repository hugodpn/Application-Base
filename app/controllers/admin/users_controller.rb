class Admin::UsersController < ApplicationController

  def index
    permission_deny unless current_user.has_perm?("listing_users")
    @users = User.all
  end

  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @article }
    end
  end

end