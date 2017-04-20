class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    @user = User.find_by(email: params[:email])
    if !@user.nil? && @user.password == params[:password]
      session[:user_id] = @user.id
      redirect_to @user
    else
      redirect_to '/login', notice: 'Incorrect email or password.'
    end
  end

  def destroy
    reset_session
    redirect_to '/'
  end
end
