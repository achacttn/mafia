class ApplicationController < ActionController::Base

  before_action :fetch_user

  def check_if_logged_in
    unless @current_user.present?
      flash[:error] = "You must be logged in to view the page."
      redirect_to login_path
    end
  end

  private

  def fetch_user
    if session[:user_id].present?
      @current_user = User.find_by id: session[:user_id]
    end

    session[:user_id] = nil unless @current_user.present?
  end
end
