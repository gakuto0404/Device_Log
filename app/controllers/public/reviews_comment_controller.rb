class Public::ReviewsCommentController < ApplicationController
  before_action :guest_review_comment_user, only: :create

  def create
    review = Review.find(params[:review_id])
    review_comments = current_user.review_comments.new(review_comment_params)
    review_comments.review_id = review.id
    if review_comments.save
      redirect_to public_review_path(review), notice: 'レビューへのコメントができました。'
    else
      redirect_to public_review_path(review), alert: 'レビューへコメントができませんでした。'#renderに変えたい
    end
  end

  def destroy
    ReviewComment.find(params[:id]).destroy
    redirect_to public_review_path(params[:review_id]), notice: 'レビューのコメントを削除しました。'
  end

  private

  def review_comment_params
    params.require(:review_comment).permit(:comment)
  end

  def guest_review_comment_user
    review = Review.find(params[:review_id])
    if current_user.email == 'guest@example.com'
      redirect_to public_review_path(review), alert: 'ゲストユーザーでコメントはできません。'
    end
  end
end
