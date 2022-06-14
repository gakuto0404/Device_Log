# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  def reject_user
    #ログイン時に入力された名前に対応するユーザーが存在するかサーチ
    @user = User.find_by(email: params[:user][:email])
    if @user
      #入力されたパスワードが正しいこと      ＠userのactive_for_authentication?メソッドがtrueであるかどうか
      if @user.valid_password?(params[:user][:password]) && (@user.is_active == true)
        redirect_to new_user_registration, alert: '退会済みのアカウントです。'
      end
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
