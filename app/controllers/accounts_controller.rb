class AccountsController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to edit_account_path, notice: 'Account updated successfully.'
    else
      flash.now[:alert] = 'There were problems updating your account.'
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :phone_number, :telegram_chat_id)
  end
end