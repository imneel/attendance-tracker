class AttendancesController < ApplicationController
  def index
    @attendances = Attendance.includes(:user).order(date: :desc, tod: :desc).page(params[:page])
    @stats = get_todays_stats
  end

  def create
    user = User.find_by(username: params[:username])
    if user
      t_now = Time.zone.now
      is_late = t_now.seconds_since_midnight >= 36060
      attendance = user.attendances.build(date: t_now.to_date, tod: t_now.strftime("%H:%M:%S"))
      if attendance.save
        redirect_to home_path, flash: { notice: is_late ? nil : "Successfully checked-in #{params[:username].inspect}.", error: is_late ? "Checked-in, but you are late today." : nil }
      else
        redirect_to home_path, flash: { error: attendance.errors.messages.values.flatten.to_sentence }
      end
    else
      redirect_to home_path, flash: { error: "Invalid username #{params[:username].inspect}." }
    end
  end

  private

  def get_todays_stats
    { late: Attendance.where(date: Date.today).where("tod >= '10:01:00'").count }
  end
end
