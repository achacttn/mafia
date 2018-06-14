class SessionController < ApplicationController
  def new
  end

  def create
    user = User.find_by name: params[:name]
    # raise "hell"
    if user.present? && user.authenticate( params[:password])
      session[:user_id] = user.id
      cookies.encrypted[:user_id] = user.id   # need this for ActionCable (websockets)
      redirect_to rooms_path
    else
      flash[:error] = "Invalid email address or password"
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    cookies.encrypted[:user_id] = nil
    redirect_to login_path
  end
end
