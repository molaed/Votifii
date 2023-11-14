class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    #If search, only show search
    if params[:search]
      @users = User.where('name LIKE ?', "%#{params[:search]}%")
    else
      @users = User.all
    end
  end
  
  def show
      @user = User.find(params[:id])

    # Use @user in your view to display user information
  end
  def create
    @user = User.find(params[:id])
    #@user.name = @user.email
    @user.save
  end
  def edit
    @user = User.find(params[:id])
    # Use @user in your view to pre-fill the form with existing user information
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'Profile updated successfully.'
    else
      render :edit
    end
  end

  private


  def user_params
    params.require(:user).permit(:name, :candidate, :currentPosition, :experience, :education, :accolades, :connections)
  end
end
