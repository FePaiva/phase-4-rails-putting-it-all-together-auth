class UsersController < ApplicationController
  skip_before_action :authorize_user, only: :create

  def create
    user = User.create(user_params)
    if user.valid?
      session[:user_id] = user.id
      render json: user, status: :created
    else
      render json: { errors: [user.errors.full_messages] }, status: :unprocessable_entity
    end
  end

  # def show
  #   user = User.find_by(id: session[:user_id])
  #   if user
  #     render json: user
  #   else
  #     render json: {error: "Not authorized"}, status: :unauthorized
  #   end
  # end
  
  def show
    render json: @current_user
  end
  
  private
  def user_params
    params.permit(:username, :image_url, :bio, :password, :password_confirmation)
  end

  def authorize
    return render json: { error: "Not authorized" }, status: :unauthorized unless session.include? :user_id
  end

end

  

