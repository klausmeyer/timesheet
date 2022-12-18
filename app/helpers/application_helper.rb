module ApplicationHelper
  def value_or_dash(value)
    value.presence || "-"
  end

  def color_coded_number(number)
    return if number.nil?

    content_tag :span, class: {number: true, "number-positive": number.positive?, "number-negative": number.negative?} do
      concat number.negative? ? "- " : "+ "
      concat humanized_duration(number).to_s
    end
  end

  def humanized_duration(duration)
    return if duration.nil?

    duration = duration.abs

    hours   = duration.floor
    minutes = (duration % 1.0) * 60

    "%dh %dm" % [hours, minutes]
  end
end
