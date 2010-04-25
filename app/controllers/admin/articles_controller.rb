class Admin::ArticlesController < ApplicationController

  # GET /admin/articles
  # GET /admin/articles.xml
  def index
    unless current_user.has_perm?("articles_article_can_listing")
      permission_deny
    else
      @articles = Article.all

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @articles }
      end
    end
  end

  # GET /admin/articles/1
  # GET /admin/articles/1.xml
  def show
    unless current_user.has_perm?("articles_article_can_view")
      permission_deny 
    else
      @article = Article.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @article }
      end
    end
  end

  # GET /admin/articles/new
  # GET /admin/articles/new.xml
  def new
    unless current_user.has_perm?("articles_article_can_create")
      permission_deny 
    else
      @article = Article.new

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @article }
      end
    end
  end

  # GET /admin/articles/1/edit
  def edit
    unless current_user.has_perm?("articles_article_can_update")
      permission_deny
    else
      @article = Article.find(params[:id])
    end
  end

  # POST /admin/articles
  # POST /admin/articles.xml
  def create
    unless current_user.has_perm?("articles_article_can_create")
      permission_deny
    else
      @article = Article.new(params[:article])

      respond_to do |format|
        if @article.save
          flash[:notice] = 'Article was successfully created.'
          format.html { redirect_to([:admin, @article]) }
          format.xml  { render :xml => @article, :status => :created, :location => @article }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # PUT /admin/articles/1
  # PUT /admin/articles/1.xml
  def update
    unless current_user.has_perm?("articles_article_can_update")
      permission_deny
    else
      @article = Article.find(params[:id])

      respond_to do |format|
        if @article.update_attributes(params[:article])
          flash[:notice] = 'Article was successfully updated.'
          format.html { redirect_to([:admin, @article]) }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /admin/articles/1
  # DELETE /admin/articles/1.xml
  def destroy
    unless current_user.has_perm?("articles_article_can_destroy")
      permission_deny
    else
      @article = Article.find(params[:id])
      @article.destroy

      respond_to do |format|
        format.html { redirect_to(admin_articles_url) }
        format.xml  { head :ok }
      end
    end
  end
end
