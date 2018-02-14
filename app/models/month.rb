class Month
  attr_accessor :target

  def initialize(target=Date.today)
    @target = target
  end

  def days
    beginning_of_month = @target.beginning_of_month
    end_of_month = @target.end_of_month
    day = beginning_of_month
    days = []
    while day <= end_of_month
      days << day
      day = day.next
    end
    days
  end
end