class ReviewsController < ApplicationController
  def index
    @reviews = Review.all
  end

  def new
    @lifehack = Lifehack.find(params[:lifehack_id])
    @review = Review.new
    @rating_list = Review::RATING_LIST
  end

  def create
    @lifehack = Lifehack.find(params[:lifehack_id])
    @review = Review.new(review_params)
    @user = current_user
    @review.lifehack = @lifehack
    @review.creator = @user
    if @review.save
      redirect_to lifehack_path(@lifehack), notice: 'Review made!'
    else
      @rating_list = Review::RATING_LIST
      flash.now[:error] = "Review rating can't be blank!"
      render :new
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment, :creator_id)
  end
end
