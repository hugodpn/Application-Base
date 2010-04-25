class Admin::RolesController < ApplicationController

  def index
    unless current_user.has_perm?("roles_role_can_list")
      permission_deny
    else
      @roles = Role.find(:all)
    end
  end

  def new
    unless current_user.has_perm?("roles_role_can_create")
      permission_deny
    else
      @role = Role.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @role }
      end
    end
  end

  def create
    unless current_user.has_perm?("roles_role_can_create")
      permission_deny
    else
      @role = Role.new(params[:role])

      respond_to do |format|
        if @role.save
          flash[:notice] = 'Role was successfully created.'
          format.html { redirect_to([:admin, @role]) }
          format.xml  { render :xml => @role, :status => :created, :location => @role }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @role.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  def show
    unless current_user.has_perm?("roles_role_can_show")
      permission_deny
    else
      @role = Role.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @role }
      end
    end
  end

  def destroy
    unless current_user.has_perm?("roles_role_can_destroy")
      permission_deny
    else
      @role = Role.find(params[:id])
      @role.destroy

      respond_to do |format|
        format.html { redirect_to(admin_roles_path) }
        format.xml  { head :ok }
      end
    end
  end

  def edit
    unless current_user.has_perm?("roles_role_can_update")
      permission_deny
    else
      @role = Role.find(params[:id])
    end
  end

  def update
    unless current_user.has_perm?("roles_role_can_update")
      permission_deny
    else
      @role = Role.find(params[:id])

      respond_to do |format|
        if @role.update_attributes(params[:role])
          flash[:notice] = 'Role was successfully updated.'
          format.html { redirect_to([:admin, @role]) }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @role.errors, :status => :unprocessable_entity }
        end
      end
    end
  end


  def save_permissions

    @role = Role.find(params[:form][:role_id])

    params[:permission].each do |perm, value|

      if @role.permissions.map(&:action).include?(perm)
        p = @role.permissions.find_by_action(perm)
        p.granted = (value=="G")?true:(value=="D")?false:nil
        p.save
      else
        @role.permissions << Permission.new(:action => perm, :granted => (value=="G")?true:(value=="D")?false:nil) if value != ""
      end

    end

    if @role.save
      @saved_message = "Permissions was saved!!"
    end

  end
  
end