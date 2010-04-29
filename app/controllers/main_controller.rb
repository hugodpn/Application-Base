class MainController < ApplicationController

  skip_before_filter :require_authentification, :only => [:index]

  def initialize
    
  end

  def index
    @articles = Article.paginate :page => params[:page], :order => 'created_at DESC'
  end
  
end
