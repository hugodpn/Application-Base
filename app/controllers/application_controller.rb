# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  filter_parameter_logging :password, :password_confirmation
  before_filter :require_authentification
  before_filter :set_user_language

  helper_method :current_user

  private
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    @current_user = current_user_session && current_user_session.record
  end
  
  def require_authentification
    unless current_user
      flash[:notice] = "You should be loggin."
      redirect_to "/login"
    end
  end

  def permission_deny
    flash[:notice] = "Permissions deny."
    redirect_to root_url
  end

  def validate_permission permission="other"
    unless current_user and  current_user.has_perm?(permission)
      permission_deny
    end
  end

  def set_user_language
    if current_user
      I18n.locale = current_user.language
    else
      I18n.locale = "en"
    end
  end

end
