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

    parts = ActiveSupport::Duration.build(duration.hours).parts.except(:seconds)

    return '0' if parts.blank?

    parts[:hours] += parts.delete(:days) * 24.0 if parts.key?(:days)

    parts.collect do |key, val|
      t(:"datetime.humanized_duration.x_#{key}", count: val)
    end.join(', ')
  end
end
