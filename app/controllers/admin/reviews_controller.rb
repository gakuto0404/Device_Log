class Admin::ReviewsController < ApplicationController


  def index
    @genres = Genre.all
    @reviews = Review.all
  end

  def show
    @review = Review.find(params[:id])
    @user = @review.user
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
     @review = Review.find(params[:id])
    if @review.update(review_params)
      redirect_to admin_review_path(@review.id)
    else
      render :edit
    end
  end

  def destroy
    @review = Reviews.find(params[:id])
    @review.destroy
    redirect_to admin_reviews_path
  end

  private
  def review_params
    params.require(:review).permit(:image, :title, :item_name, :genre_id, :manufacture_name, :impressions, :purchase_price, :purchase_source)
  end
end