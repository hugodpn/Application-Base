class Admin::CategoriesController < ApplicationController

  #  skip_before_filter :require_authentification, :only => [:index, :new, :create]

  # GET /categories
  # GET /categories.xml
  def index
    unless current_user.has_perm?("categories_category_can_list")
      permission_deny
    else
      @categories = Category.all

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @categories }
      end
    end
  end

  # GET /categories/1
  # GET /categories/1.xml
  def show
    unless current_user.has_perm?("categories_category_can_show")
      permission_deny
    else
      @category = Category.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @category }
      end
    end
  end

  # GET /categories/new
  # GET /categories/new.xml
  def new
    unless current_user.has_perm?("categories_category_can_create")
      permission_deny
    else
      @category = Category.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @category }
      end
    end
  end

  # GET /categories/1/edit
  def edit
    unless current_user.has_perm?("categories_category_can_update")
      permission_deny
    else
      @category = Category.find(params[:id])
    end
  end

  # POST /categories
  # POST /categories.xml
  def create
    unless current_user.has_perm?("categories_category_can_create")
      permission_deny
    else
      @category = Category.new(params[:category])

      respond_to do |format|
        if @category.save
          flash[:notice] = 'Category was successfully created.'
          format.html { redirect_to([:admin, @category]) }
          format.xml  { render :xml => @category, :status => :created, :location => @category }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # PUT /categories/1
  # PUT /categories/1.xml
  def update
    unless current_user.has_perm?("categories_category_can_update")
      permission_deny
    else
      @category = Category.find(params[:id])

      respond_to do |format|
        if @category.update_attributes(params[:category])
          flash[:notice] = 'Category was successfully updated.'
          format.html { redirect_to([:admin, @category]) }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.xml
  def destroy
    unless current_user.has_perm?("categories_category_can_destroy")
      permission_deny
    else
      @category = Category.find(params[:id])
      @category.destroy

      respond_to do |format|
        format.html { redirect_to(admin_categories_url) }
        format.xml  { head :ok }
      end
    end
  end
end
