class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update]

  def index
    @users = User.all
  end

  def edit; end

  def update
    if @user.update(user_update_params)
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
    params.require(:user).permit(:name, :username, :email, :phone, :website)
  end

  def address_params
    params.require(:user).permit(:address_street, :address_suite, :address_city,
                                 :address_zipcode, address_geo: [:lat, :lng])
  end

  def company_params
    params.require(:user).permit(:company_name, :company_catchPhrase, :company_bs)
  end

  def user_update_params
    user_params.merge(
      address: {
        street: params[:user][:address_street],
        suite: params[:user][:address_suite],
        city: params[:user][:address_city],
        zipcode: params[:user][:address_zipcode],
        geo: {
          lat: params[:user][:address_geo_lat],
          lng: params[:user][:address_geo_lng]
        }
      },
      company: {
        name: params[:user][:company_name],
        catchPhrase: params[:user][:company_catchPhrase],
        bs: params[:user][:company_bs]
      }
    )
  end
end
