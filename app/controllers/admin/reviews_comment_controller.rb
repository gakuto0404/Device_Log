class Admin::ReviewsCommentController < ApplicationController

  def destroy
    ReviewComment.find(params[:id]).destroy
    redirect_to admin_review_path(params[:review_id])
  end

  private

  def review_comment_params
    params.require(:review_comment).permit(:comment)
  end

end
