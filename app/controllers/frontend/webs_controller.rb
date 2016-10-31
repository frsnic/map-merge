class Frontend::WebsController < ApplicationController

  def index
    @maps = Map.all
  end

  def dots
    @map  = Map.find(params[:map_id])
    @dots = @map.dots.includes(:user, :map).all

    render 'frontend/webs/index.kml.builder'
  end

end
