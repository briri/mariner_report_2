module ApplicationHelper

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
  
end
