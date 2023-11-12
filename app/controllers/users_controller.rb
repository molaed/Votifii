class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update]

  def index
    @users = User.all
  end
  
  def show
    # Use @user in your view to display user information
  end

  def edit
    # Use @user in your view to pre-fill the form with existing user information
  end

  def update
    if @user.update(user_params)
      redirect_to user_path, notice: 'Profile updated successfully.'
    else
      render :edit
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :candidate, :currentPosition, :experience, :education, :accolades, :connections)
  end
end
