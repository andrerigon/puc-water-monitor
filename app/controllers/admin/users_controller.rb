module Admin
  class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :admin_only

    def index
      @users = User.all
    end

    def new
      @user = User.new
    end

    def create
      @user = User.new(user_params)
      if @user.save
        redirect_to admin_users_path, notice: 'User was successfully created.'
      else
        render :new
      end
    end

    def edit
      @user = User.find(params[:id])
    end

    def update
      @user = User.find(params[:id])
      if @user.update(user_params)
        redirect_to admin_users_path, notice: 'User was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @user = User.find(params[:id])
      @user.destroy
      redirect_to admin_users_path, notice: 'User was successfully deleted.'
    end

    private

    def user_params
      params.require(:user).permit(:name, :email, :phone_number, :password, :password_confirmation, :admin, :receive_updates, :telegram_chat_id)
    end

    def admin_only
      unless current_user.admin?
        redirect_to root_path, alert: 'Access denied.'
      end
    end
  end
end