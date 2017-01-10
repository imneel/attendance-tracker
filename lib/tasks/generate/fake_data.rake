namespace :generate do
  task fake_data: :environment do
    puts "Generating fake data for 50 users 3 month attendance"
    starts_on = 3.months.ago.beginning_of_month.to_date
    ends_on = Date.today
    50.times do |i|
      puts "Generating data for emp#{i}"
      emp = User.find_by(username: "emp#{i}") || User.create(username: "emp#{i}")
      starts_on.upto(ends_on) do |date|
        Attendance.find_by(user_id: emp.id, date: date) || Attendance.create(user_id: emp.id, date: date, tod: Tod::TimeOfDay.parse("9:59:00") + rand(600))
      end
    end
  end
end