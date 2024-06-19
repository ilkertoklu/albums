class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update]

  def index
    @users = User.all
  end

  def edit; end

  def update
    if @user.update(user_params.merge(address: address_params))
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :username, :email, :phone)
  end

  def address_params
    {
      street: params[:user][:street],
      suite: params[:user][:suite],
      city: params[:user][:city],
      zipcode: params[:user][:zipcode],
      geo: {
        lat: params[:user][:geo_lat],
        lng: params[:user][:geo_lng]
      }
    }
  end
end
