module DateAndTimeHelper
  def select_date(date, from:)
    date = Date.parse(date)
    select date.strftime("%Y"), from: "#{from}_1i"
    select date.strftime("%B"), from: "#{from}_2i"
    select date.strftime("%-d"), from: "#{from}_3i"
  end

  def select_time(time, from:)
    time = Time.parse(time)
    select time.strftime("%H"), from: "#{from}_4i"
    select time.strftime("%M"), from: "#{from}_5i"
  end
end
