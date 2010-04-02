class MainController < ApplicationController

  skip_before_filter :require_authentification, :only => [:index]

  def initialize
    
  end

  def index
    
  end
end
