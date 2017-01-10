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
    @attendances = @user.attendances.select("attendances.*", "tod >= '10:01:00' AS late").
      order(date: :desc, tod: :desc).page(params[:page])
    @stats = {
      late: @user.attendances.where("tod >= '10:01:00'").count,
      t_avg: @user.attendances.pluck("AVG(tod::time)").first.split(".").first,
      total: @user.attendances.count
    }
  end

  private
  def create_params
    params[:user].permit(:username)
  end
end
