class Public::ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :guest_review_user, only: %i[new create]

  def index
    @genres = Genre.all
    #@reviews = Review.all
    @search_params = review_search_params
    @reviews = Review.search(@search_params).includes(:genre)
  end

  def new
    @review = Review.new
  end

  def create
    @review = current_user.reviews.new(review_params)
    if @review.save
      redirect_to public_review_path(@review.id), notice: 'レビューの投稿できました。'
    else
      redirect_to new_public_reviews_path, alert: 'レビューの投稿ができませんでした。'#renderに変えたい
    end
  end

  def show
    @review = Review.find(params[:id])
    @user = @review.user
    @review_comment = ReviewComment.new
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
     @review = Review.find(params[:id])
    if @review.update(review_params)
      redirect_to public_review_path(@review.id), notice: 'レビューの編集できました。'
    else
      render :edit, alert: 'レビューの編集ができませんでした。'
    end
  end

  def destroy
    @review = current_user.reviews.find(params[:id])
    @review.destroy
    redirect_to public_user_path(current_user.id), notice: 'レビューの削除ができました。'
  end

  private

  def review_params
    params.require(:review).permit(:image, :title, :item_name, :genre_id, :manufacture_name, :impressions, :purchase_price, :purchase_source)
  end

  def review_search_params
    params.fetch(:search, {}).permit(:item_name, {:genre_ids => []})
  end

  def guest_review_user
    if current_user.email == 'guest@example.com'
      redirect_to root_path, alert: 'ゲストユーザーのレビューはできません。'
    end
  end
end