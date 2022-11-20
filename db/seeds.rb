# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

user = User.first_or_create do |u|
  u.daily_working_hours = 8.0
end

if user.entries.none? && ENV['DUMMY_ENTRIES'].present?
  user.entries << Entries::Manual.new(date: '2021-12-31', time_manual: 23.0)

  user.entries << Entries::General.new(date: '2022-10-31', start_time: '08:59', end_time: '17:29')
  user.entries << Entries::Holiday.new(date: '2022-11-01')
  user.entries << Entries::General.new(date: '2022-11-02', start_time: '08:59', end_time: '17:29')
  user.entries << Entries::General.new(date: '2022-11-03', start_time: '08:59', end_time: '17:59')
  user.entries << Entries::General.new(date: '2022-11-04', start_time: '09:59', end_time: '17:29')

  user.entries << Entries::General.new(date: '2022-11-07', start_time: '08:59', end_time: '17:29')
  user.entries << Entries::General.new(date: '2022-11-08', start_time: '08:59', end_time: '17:29')
  user.entries << Entries::General.new(date: '2022-11-09', start_time: '08:59', end_time: '17:29')
  user.entries << Entries::General.new(date: '2022-11-10', start_time: '08:59', end_time: '17:29')
  user.entries << Entries::Flextime.new(date: '2022-11-11')
end
