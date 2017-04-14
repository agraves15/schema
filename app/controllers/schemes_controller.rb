class SchemesController < ApplicationController
  before_action :set_scheme, only: [:show, :edit, :update, :destroy]

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
  end

  # GET /schemes/1/edit
  def edit
  end

  # POST /schemes
  # POST /schemes.json
  def create
    @scheme = Scheme.new(scheme_params)

    respond_to do |format|
      if @scheme.save
        format.html { redirect_to @scheme, notice: 'Scheme was successfully created.' }
        format.json { render :show, status: :created, location: @scheme }
      else
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
        format.html { redirect_to @scheme, notice: 'Scheme was successfully updated.' }
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
      format.html { redirect_to schemes_url, notice: 'Scheme was successfully destroyed.' }
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
      params.require(:scheme).permit(:name, :private, :shared)
    end
end
