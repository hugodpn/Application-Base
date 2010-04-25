class MainController < ApplicationController

  skip_before_filter :require_authentification, :only => [:index]

  def initialize
    
  end

  def index
    @articles = Article.find(:all, :order => "created_at desc")
  end
end
