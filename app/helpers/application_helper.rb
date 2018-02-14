module ApplicationHelper

  # For index, show, back
  def default_btn_class
    'waves-effect btn grey lighten-5 black-text'
  end

  # For new, create
  def create_btn_class
    'waves-effect waves-light btn green accent-2 black-text'
  end

  # For edit, update
  def update_btn_class
    'waves-effect waves-light btn orange accent-2 black-text'
  end

  # For delete, alert
  def danger_btn_class
    'waves-effect waves-light btn red accent-2 black-text'
  end

  # For signup, login
  def session_btn_class
    'waves-effect waves-teal btn'
  end

  def week_day_class(wday)
    case wday
    when 0 then 'wday-holiday'
    when 6 then 'wday-sat'
    else
      'wday'
    end
  end
end
