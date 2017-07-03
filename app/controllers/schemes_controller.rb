class SchemesController < ApplicationController
  before_action :set_scheme, only: [:show, :edit, :update, :destroy, :share, :share_with_user, :unshare_with_user]

  # GET /schemes
  # GET /schemes.json
  def index
    @schemes = Scheme.all
  end

  # GET /schemes/1
  # GET /schemes/1.json
  def show
  end

  # GET /schemes/new
  def new
    @scheme = Scheme.new
    6.times do
      @scheme.colors.build
    end
  end

  # GET /schemes/1/edit
  def edit
  end

  # POST /schemes
  # POST /schemes.json
  def create
    @scheme = Scheme.new(name: scheme_params[:name], private: scheme_params[:private], shared: scheme_params[:shared])
    (0..scheme_params[:colors_attributes].count - 1).each do |i|
      @scheme.add_color(scheme_params, i)
    end

    respond_to do |format|
      if @scheme.save
        current_user.schemes.append @scheme
        format.html { redirect_to @scheme, notice: 'Color scheme was successfully created.' }
        format.json { render :show, status: :created, location: @scheme }
      else
        6.times do
          @scheme.colors.build
        end
        format.html { render :new }
        format.json { render json: @scheme.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /schemes/1
  # PATCH/PUT /schemes/1.json
  def update
    respond_to do |format|
      if @scheme.update(scheme_params)
        @scheme.colors.sort
        format.html { redirect_to @scheme, notice: 'Color scheme was successfully updated.' }
        format.json { render :show, status: :ok, location: @scheme }
      else
        format.html { render :edit }
        format.json { render json: @scheme.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /schemes/1
  # DELETE /schemes/1.json
  def destroy
    @scheme.destroy
    respond_to do |format|
      format.html { redirect_to schemes_url, notice: 'Color scheme was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def share
    render :share
  end

  def share_with_user
    user = User.find(params[:share_with])
    @scheme.add_user(user)
    respond_to do |format|
      format.html { redirect_to share_scheme_url, notice: 'Color scheme was successfully shared with ' + user.name + '.' }
      format.json { head :no_content }
    end
  end

  def unshare_with_user
    user = User.find(params[:unshare_with])
    @scheme.remove_user(user)
    respond_to do |format|
      format.html { redirect_to share_scheme_url, notice: user.name + ' was successfully unshared from this color scheme.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_scheme
    @scheme = Scheme.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def scheme_params
    params.require(:scheme).permit(:name, :private, :shared, colors_attributes: [:id, :name])
  end
end
