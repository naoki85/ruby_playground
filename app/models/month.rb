class Month
  def self.days
    beginning_of_month = Date.today.beginning_of_month
    end_of_month = Date.today.end_of_month
    day = beginning_of_month
    days = []
    while day <= end_of_month
      days << day
      day = day.next
    end
    days
  end
end