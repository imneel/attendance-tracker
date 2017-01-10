class AttendancesController < ApplicationController
  def index
    @attendances = Attendance.includes(:user).select("attendances.*", "tod >= '10:01:00' AS late").
      order(date: :desc, tod: :desc).page(params[:page])
    @stats = get_todays_stats
  end

  def charts
    @stats = get_charts_data
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
    {
      late: Attendance.where(date: Date.today).where("tod >= '10:01:00'").count,
      t_avg: Attendance.where(date: Date.today).pluck("AVG(tod::time)").first.split(".").first,
      total: Attendance.where(date: Date.today).count
    }
  end

  def get_charts_data
    {
      daily: get_stats_for(:date, 60),
      monthly: get_stats_for("DATE_TRUNC('month', date)::date", 60),
      weekly: get_stats_for("DATE_TRUNC('week', date)::date", 60)
    }
  end

  def get_stats_for(group_fn, limit)
    Attendance.group(group_fn).order(group_fn).
      pluck(group_fn, "COUNT(*)", "COUNT(CASE WHEN tod >= '10:01:00' THEN 1 ELSE NULL END)", "AVG(tod::time)").
      last(limit || 50)
  end
end
