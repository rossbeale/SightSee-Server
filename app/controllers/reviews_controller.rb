class ReviewsController < ApplicationController
  
  # POST /reviews (XML/JSON)
  def create
    if params[:uid] && params[:review_location] && params[:reviewer_name] && params[:review_comment] && params[:review_score]
      @location = Location.find(params[:review_location])
      if @location
        @existing_review = Review.where(:uid => params[:uid], :location_id => @location.id)
        if @existing_review.count > 0
          output = {'response' => 'failed'}.to_json
          render json: output
        else
          @review = Review.new(:uid => params[:uid], :reviewer_name => params[:reviewer_name], :review_comment => params[:review_comment], :review_score => params[:review_score])
          @review.location = @location
          @review.save!
          render json: @review.id_as_json
        end
      else
        head :bad_request
      end
    else
      head :bad_request
    end
  end
  
end
