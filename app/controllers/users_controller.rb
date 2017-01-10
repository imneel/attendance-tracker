class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(create_params)
    if @user.save
      redirect_to home_path, notice: "User #{@user.username} created successfully"
    else
      render :new
    end
  end

  def destroy
    user = User.find(params[:id])
    if user.destroy
      flash.notice = "User #{user.username} deleted successfully."
      redirect_to attendances_path
    else
      flash.notice = "Failed to delete user #{user.username}."
      redirect_to user_path(user)
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private
  def create_params
    params[:user].permit(:username)
  end
end
