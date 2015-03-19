module AuthHelper
   def current_user
    if session[:user_id]
      Student.find(session[:user_id])
    else
      return nil
    end
  end

end
