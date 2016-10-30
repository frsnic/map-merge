class Frontend::WebsController < ApplicationController

  def index
    @maps = Map.all
  end

end
