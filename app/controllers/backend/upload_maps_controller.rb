class Backend::UploadMapsController < Backend::ApplicationController
  before_action :set_map

  # GET /upload_maps/new
  def new
    @upload_map = current_user.upload_maps.new(map: @map)
  end

  # POST /upload_maps
  # POST /upload_maps.json
  def create
    @upload_map = current_user.upload_maps.new(upload_map_params)

    respond_to do |format|
      if @upload_map.save
        message = "上傳成功，新增了 #{@upload_map.dots.size} 個點"
        @upload_map.dots.size > 0 ? flash[:notice] = message : flash[:warning] = message
        format.html { redirect_to @map }
        format.json { render :show, status: :created, location: @upload_map }
      else
        format.html { render :new }
        format.json { render json: @upload_map.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_map
      @map = Map.find(params[:map_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def upload_map_params
      params.require(:upload_map).permit(:map_id, :user_id, :name, :file, :size, :content_type)
    end
end
