class ReviewsController < ApplicationController
  
  # POST /reviews (XML/JSON)
  def create
    if params[:review_location] && params[:reviewer_name] && params[:review_comment] && params[:review_score]
      @location = Location.find(params[:review_location])
      if @location
        @review = Review.new(:reviewer_name => params[:reviewer_name], :review_comment => params[:review_comment], :review_score => params[:review_score])
        @review.location = @location
        @review.save!
        render json: @review.id_as_json
      else
        head :bad_request
      end
    else
      head :bad_request
    end
  end
  
end
