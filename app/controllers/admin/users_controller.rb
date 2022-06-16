class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
     @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path, notice: 'ユーザー情報を編集しました。'
    else
      render :edit, alert: 'ユーザー情報を編集できませんでした。' #形が崩れてしまう
    end
  end

  private

  def user_params
    params.require(:user).permit(:profile_image, :nick_name, :last_name, :first_name, :email, :is_active)
  end
end
