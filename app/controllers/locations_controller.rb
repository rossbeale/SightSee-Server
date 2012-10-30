class LocationsController < ApplicationController
  
  # GET /locations (XML/JSON)
  def index
    if params[:lat] && params[:lng]
      @origin = [params[:lat], params[:lng]]
      @locations = Location.all
      @locations.sort_by_distance_from(@origin)
      render json: @locations.as_json(:usercon => params)
    else
      head :bad_request
    end
  end
  
end
