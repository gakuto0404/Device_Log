class Public::ReviewsCommentController < ApplicationController

  def create
    review = Review.find(params[:review_id])
    review_comments = current_user.review_comments.new(review_comment_params)
    review_comments.review_id = review.id
    review_comments.save
    redirect_to public_review_path(review)
  end

  def destroy
    ReviewComment.find(params[:id]).destroy
    redirect_to public_review_path(params[:review_id])
  end

  private

  def review_comment_params
    params.require(:review_comment).permit(:comment)
  end
end
