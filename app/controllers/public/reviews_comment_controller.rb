class Public::ReviewsCommentController < ApplicationController
  before_action :guest_review_comment_user, only: :create

  def create
    review = Review.find(params[:review_id])
    review_comments = current_user.review_comments.new(review_comment_params)
    review_comments.review_id = review.id
    if review_comments.save
      redirect_to public_review_path(review), notice: 'レビューへのコメントができました。'
    else
      render public_review_path(@review.id), alert: 'レビューへコメントができませんでした。'
    end
  end

  def destroy
    ReviewComment.find(params[:id]).destroy
    redirect_to public_review_path(params[:review_id])
  end

  private

  def review_comment_params
    params.require(:review_comment).permit(:comment)
  end

  def guest_review_comment_user
    if current_user.email == 'guest@example.com'
      redirect_to root_path, alert: 'ゲストユーザーでコメントはできません。'
    end
  end
end
