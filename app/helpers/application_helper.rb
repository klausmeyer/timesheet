module ApplicationHelper
  def value_or_dash(value)
    value.presence || '-'
  end

  def color_coded_number(number)
    return if number.nil?

    content_tag :span, class: {number: true, 'number-positive': number.positive? , 'number-negative': number.negative?} do
      concat '+' if number.positive?
      concat humanized_duration(number).to_s
    end
  end

  def humanized_duration(duration)
    return if duration.nil?

    parts = ActiveSupport::Duration.build(duration.hours).parts

    parts = {hours: 0} if parts == {seconds: 0}

    parts.except(:seconds).collect do |key, val|
      t(:"datetime.humanized_duration.x_#{key}", count: val)
    end.join(', ')
  end
end
