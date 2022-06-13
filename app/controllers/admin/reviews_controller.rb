class Admin::ReviewsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @genres = Genre.all
    #@reviews = Review.all
    @search_params = review_search_params
    @reviews = Review.search(@search_params).includes(:genre)
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
    Review.find(params[:id]).destroy
    redirect_to admin_reviews_path
  end

  private
  def review_params
    params.require(:review).permit(:image, :title, :item_name, :genre_id, :manufacture_name, :impressions, :purchase_price, :purchase_source)
  end

  def review_search_params
    params.fetch(:search, {}).permit(:item_name, {:genre_ids => []})
  end
end