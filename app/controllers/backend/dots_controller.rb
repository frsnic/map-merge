class Backend::DotsController < Backend::ApplicationController
  before_action :set_map
  before_action :set_dot, only: [:show, :edit, :update, :destroy]

  # GET /backend/dots
  # GET /backend/dots.json
  def index
    @dots = @map.dots.includes(:user, :map).all
  end

  # GET /backend/dots/1
  # GET /backend/dots/1.json
  def show
  end

  # GET /backend/dots/new
  def new
    @dot = @map.dots.new
  end

  # GET /backend/dots/1/edit
  def edit
  end

  # POST /backend/dots
  # POST /backend/dots.json
  def create
    @dot = @map.dots.new(dot_params)

    respond_to do |format|
      if @dot.save
        format.html { redirect_to @dot, notice: 'Dot was successfully created.' }
        format.json { render :show, status: :created, location: @dot }
      else
        format.html { render :new }
        format.json { render json: @dot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /backend/dots/1
  # PATCH/PUT /backend/dots/1.json
  def update
    respond_to do |format|
      if @dot.update(dot_params)
        format.html { redirect_to @dot, notice: 'Dot was successfully updated.' }
        format.json { render :show, status: :ok, location: @dot }
      else
        format.html { render :edit }
        format.json { render json: @dot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /backend/dots/1
  # DELETE /backend/dots/1.json
  def destroy
    @dot.destroy
    respond_to do |format|
      format.html { redirect_to dots_url, notice: 'Dot was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_map
      @map = Map.find(params[:map_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_dot
      @dot = @map.dots.includes(:user, :map).find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dot_params
      params.require(:dot).permit(:map_id, :user_id, :name, :x, :y)
    end
end
