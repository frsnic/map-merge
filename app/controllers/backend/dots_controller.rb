class Backend::DotsController < Backend::ApplicationController
  before_action :set_backend_dot, only: [:show, :edit, :update, :destroy]

  # GET /backend/dots
  # GET /backend/dots.json
  def index
    @backend_dots = Backend::Dot.all
  end

  # GET /backend/dots/1
  # GET /backend/dots/1.json
  def show
  end

  # GET /backend/dots/new
  def new
    @backend_dot = Backend::Dot.new
  end

  # GET /backend/dots/1/edit
  def edit
  end

  # POST /backend/dots
  # POST /backend/dots.json
  def create
    @backend_dot = Backend::Dot.new(backend_dot_params)

    respond_to do |format|
      if @backend_dot.save
        format.html { redirect_to @backend_dot, notice: 'Dot was successfully created.' }
        format.json { render :show, status: :created, location: @backend_dot }
      else
        format.html { render :new }
        format.json { render json: @backend_dot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /backend/dots/1
  # PATCH/PUT /backend/dots/1.json
  def update
    respond_to do |format|
      if @backend_dot.update(backend_dot_params)
        format.html { redirect_to @backend_dot, notice: 'Dot was successfully updated.' }
        format.json { render :show, status: :ok, location: @backend_dot }
      else
        format.html { render :edit }
        format.json { render json: @backend_dot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /backend/dots/1
  # DELETE /backend/dots/1.json
  def destroy
    @backend_dot.destroy
    respond_to do |format|
      format.html { redirect_to backend_dots_url, notice: 'Dot was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_backend_dot
      @backend_dot = Backend::Dot.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def backend_dot_params
      params.require(:backend_dot).permit(:map_id, :user_id, :name, :x, :y)
    end
end
