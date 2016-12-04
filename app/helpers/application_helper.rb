module ApplicationHelper

  # --------------------------------------------------------------
  def freshness(date)
    secs = (Time.new - Time.parse(date.to_s)).round(0)
    mins = (secs / 60).round(0)
    hrs = (mins / 60).round(0)
    days = (hrs / 24).round(0)

    (days > 1 ? "#{days} days ago" :
      (days == 1 ? "1 day ago" :
        (hrs > 1 ? "#{hrs} hours ago" :
          (hrs == 1 ? "1 hour ago" :
            (mins > 1 ? "#{mins} minutes ago" :
              (mins == 1 ? "1 minute ago" : "less than 1 minute ago")
            )
          )
        )
      )
    )
  end

  # --------------------------------------------------------------
  def format_date(date, with_time = false)
    if date
      dt = date.localtime
      "#{dt.day}/#{dt.month}/#{dt.year}" + (with_time ? " #{dt.hour}:#{dt.min}" : "")
    end
  end

  # --------------------------------------------------------------
  def form_error(errors, field)
    unless errors[field].empty?
      "<ul class=\"form-error\"><li>#{errors[field][0]}</li></ul>".html_safe
    end
  end
  
  # --------------------------------------------------------------
  def sortable_column_header(label, field, current_dir)
    link_to label, 
            admin_publishers_path(sort: field, dir: (current_dir == 'asc' ? 'desc' : 'asc')).html_safe
  end
  
  # --------------------------------------------------------------
  def is_authorized?(policy_name)
    current_user.has_authority?(policy_name)
  end
end
