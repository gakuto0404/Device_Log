class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end
  
  def update
     @user = current_user
    if @user.update(user_params)
      redirect_to public_user_path
    else
      render :edit
    end
  end

  def quit
    @user = current_user
  end
  
  def withdrawal
    @user = current_user
    @user.update(is_active: false)
    reset_session
    redirect_to root_path
  end
  
  private

  def user_params
    params.require(:user).permit(:profile_image, :nick_name, :last_name, :first_name, :email)
  end
end
