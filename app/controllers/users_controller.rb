class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :request_friend, :accept_friend, :decline_friend]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    @user.password = user_params[:password]

    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to @user, notice: 'Welcome to Schema, ' + @user.name + '!' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'Your account was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to '/', notice: "Your account was successfully deleted. We're sad to see you go!" }
      format.json { head :no_content }
    end
    reset_session
  end

  def request_friend
    current_user.friend_request(@user)
    respond_to do |format|
      format.html { redirect_to @user, notice: 'Friend request sent to ' + @user.name + '.' }
      format.json { head :no_content }
    end
  end

  def accept_friend
    current_user.accept_request(@user)
    respond_to do |format|
      format.html { redirect_to :back, notice: @user.name + "'s friend request accepted." }
      format.json { head :no_content }
    end
  end

  def decline_friend
    current_user.decline_request(@user)
    respond_to do |format|
      format.html { redirect_to :back, notice: @user.name + "'s friend request declined." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
