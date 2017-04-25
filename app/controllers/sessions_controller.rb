class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    @user = User.find_by(email: params[:email])
    if !@user.nil? && @user.password == params[:password]
      session[:user_id] = @user.id

      respond_to do |format|
        if !@user.requested_friends.empty?
          format.html { redirect_to @user, notice: 'You have ' + @user.requested_friends.count.to_words + ' friend requests'.pluralize(@user.requested_friends.count) + '.' }
          format.json { head :no_content }
        else
          format.html { redirect_to @user }
        end
      end
    else
      redirect_to '/login', notice: 'Incorrect email or password.'
    end
  end

  def destroy
    reset_session
    redirect_to '/'
  end
end
