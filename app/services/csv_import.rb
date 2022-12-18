require "csv"

module CsvImport
  extend self

  FILE = "/Users/meyer/Desktop/Timesheet.csv".freeze

  def run
    table = CSV.parse(File.read(FILE), headers: true, col_sep: ";")

    table.each do |row|
      date    = row["Tag"].presence
      comment = row["Kommentar"].presence

      next if date.nil?

      case comment
      when "Urlaub", "Brückentag"
        user.entries << Entries::Vacation.new(
          date:    date,
          comment: comment
        )
      when "Feiertag"
        user.entries << Entries::Holiday.new(
          date:    date,
          comment: comment
        )
      when /Stunden Abbau/
        user.entries << Entries::Flextime.new(
          date:    date,
          comment: comment
        )
      when "Krank"
        user.entries << Entries::SickLeave.new(
          date:    date,
          comment: comment
        )
      when /b(ue|ü)ro|office/i, nil
        user.entries << Entries::General.new(
          date:       date,
          start_time: row["Kommen"],
          end_time:   row["Gehen"],
          comment:    comment
        )
      when /Pauschal/
        user.entries << Entries::Manual.new(
          date:        date,
          time_manual: row["Ist"],
          comment:     comment
        )
      else
        raise NotImplementedError, comment
      end
    end
  end

  private

  def user
    @user ||= User.first
  end
end
