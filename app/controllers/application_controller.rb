class ApplicationController < ActionController::API
  include ActionController::Cookies
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  before_action :authorize_user


  
  
  # checks if the user is logged in or not
  # def current_user
  #   @current_user = User.find(session[:user_id]) if session[:user_id]
  # end
  
  # redirects the user to the login page if the current_user is false
  # def require_user
  #   redirect_to '/login' unless current_user
  # end
  
  # def authorized_user
  #   return render json: {error: "Not authorized"}, status: :unauthorized unless current_user
  # end
  
  # private
  #   def render_not_found(e)
  #       render json: {error: "#{e.model}NOT FOUND :("}, status: :not_found
  #   end 
  
  def authorize_user
    @current_user = User.find_by(id: session[:user_id])

    render json: { errors: ["Not authorized"] }, status: :unauthorized unless @current_user
  end

  def render_unprocessable_entity_response(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end

end
