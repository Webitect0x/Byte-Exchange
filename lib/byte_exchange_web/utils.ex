defmodule ByteExchangeWeb.Utils do
  def days_ago(date) do
    current_datetime = DateTime.utc_now()

    days_difference = DateTime.diff(current_datetime, date)
    days = div(days_difference, 86_400)

    if days < 1 do
      hours = div(days_difference, 3600)
      "#{hours} hours ago"
    else
      "#{days} days ago"
    end
  end
end
