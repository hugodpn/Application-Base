class Admin::UsersController < ApplicationController

  def index
    unless current_user.has_perm?("users_user_can_list")
      permission_deny
    else
      @users = User.all
    end
  end

  def show
    unless current_user.has_perm?("users_user_can_show")
      permission_deny
    else
      @user = User.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @article }
      end
    end
  end

  def edit
    unless current_user.has_perm?("users_user_can_update")
      permission_deny
    else
      @user = User.find(params[:id])
      @roles = Role.find(:all)
    end
  end

  def update
    unless current_user.has_perm?("users_user_can_update")
      permission_deny
    else
      params[:user][:role_ids] ||= []
      @user = User.find(params[:id])

      respond_to do |format|
        if @user.update_attributes(params[:user])
          flash[:notice] = 'User was successfully updated.'
          format.html { redirect_to([:admin, @user]) }
          format.xml  { head :ok }
        else
          @roles = Role.find(:all)
          format.html { render :action => "edit" }
          format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  def new
    unless current_user.has_perm?("users_user_can_create")
      permission_deny
    else
      @user = User.new
      @roles = Role.find(:all)

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @user }
      end
    end
  end

  def create
    unless current_user.has_perm?("users_user_can_create")
      permission_deny
    else
      @user = User.new(params[:user])

      respond_to do |format|
        if @user.save
          flash[:notice] = 'User was successfully created.'
          format.html { redirect_to([:admin, @user]) }
          format.xml  { render :xml => @user, :status => :created, :location => @user }
        else
          @roles = Role.find(:all)
          format.html { render :action => "new" }
          format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    unless current_user.has_perm?("users_user_can_destroy")
      permission_deny
    else
      @user = User.find(params[:id])
      @user.destroy

      respond_to do |format|
        format.html { redirect_to(admin_users_url) }
        format.xml  { head :ok }
      end
    end
  end
  
end