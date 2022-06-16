class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_normal_user, only: %i[edit update withdrawal]

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews
  end

  def edit
    @user = current_user
  end

  def update
     @user = current_user
    if @user.update(user_params)
      redirect_to public_user_path, notice: 'ユーザー情報を編集しました。'
    else
      render :edit, alert: 'ユーザー情報を編集できませんでした。' #形が崩れてしまう
    end
  end

  def quit
    @user = current_user
  end

  def withdrawal
    @user = current_user
    @user.update(is_active: false)
    reset_session
    redirect_to root_path, notice: '退会しました。'
  end

  private

  def user_params
    params.require(:user).permit(:profile_image, :nick_name, :last_name, :first_name, :email)
  end

  def ensure_normal_user
    if current_user.email == 'guest@example.com'
      redirect_to root_path, alert: 'ゲストユーザーの編集・退会はできません。'
    end
  end
end
