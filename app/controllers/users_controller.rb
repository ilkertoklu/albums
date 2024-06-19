class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update]

  def index
    @users = User.all
  end

  def edit
    @user
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :username, :email, :phone, :address, :avatar)
  end
end
