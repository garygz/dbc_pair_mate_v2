class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user
  skip_before_filter  :verify_authenticity_token
  #TODO use CSRF correctly

  def current_user
      if session[:user_id]
        Student.find(session[:user_id])
      else
        return nil
      end
    end


end
