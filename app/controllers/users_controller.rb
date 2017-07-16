class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]

  def edit
  end

  def update
    update_params = params[:user][:password].blank? ? user_params : user_params_with_password
    if @user.update(update_params)
      flash[:success] = t('application.messages.users.successfully_updated')
      redirect_to root_path
    else
      flash.now[:error] = @user.errors.full_messages
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = t('application.messages.users.successfully_deleted')
    redirect_to new_user_registration_path
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(
      :name,
      :avatar,
      :_destroy
    )
  end

  def user_params_with_password
    params.require(:user).permit(
      :name,
      :password,
      :password_confirmation,
      :avatar,
      :_destroy
    )
  end
end
