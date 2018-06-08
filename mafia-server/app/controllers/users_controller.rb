class UsersController < ApplicationController

  before_action :check_if_logged_in, only: [:show]

  def new
  @user = User.new
end

def create
  user = User.create user_params

  if user.persisted?
    session[:user_id] = user.id
    image = Cloudinary::Uploader.upload(params[:file])
    user.image = image["public_id"]
    user.save

    redirect_to user_path(user.id)
  else
    flash[:errors] = user.errors.full_messages
    redirect_to new_user_path
  end
end

def index
end

def show
  @user = User.find params[:id]
end

def update
  if @current_user.update user_params
    if params[:file].present?
      req = Cloudinary::Uploader.upload(params[:file])
      @current_user.image = req["public_id"]
      @current_user.save
    end
    redirect_to user_path
  else
    flash[:errors] = @current_user.errors.full_messages
    redirect_to edit_user_path
  end

end

def edit
  @user = User.find params[:id]
end

private

def user_params
  params.require(:user).permit(:name, :email, :password, :password_confirmation)
end

end
