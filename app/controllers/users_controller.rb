class UsersController < ApplicationController

  def index
    @users = User.top_rated.paginate(page: params[:page], per_page: 10)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.visible_to(current_user)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to @user, notice: "User was saved successfully."
    else
      flash[:error] = "Error saving user. Please try again."
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :avatar, :email_favorites)
  end

end