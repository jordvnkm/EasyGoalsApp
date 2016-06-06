class SessionsController < ApplicationController

  before_action :skip_login, except: [:destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])
    if @user
      login_user!(@user)
      redirect_to goals_url
    else
      flash.now[:errors] = ["Incorrect login info"]
      render :new
    end
  end

  def destroy
    logout_user
    redirect_to new_session_url
  end
end
