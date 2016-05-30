module Listable
  def format_description(description)
    "#{description}".ljust(30)
  end
  def format_priority(priority)
    if (priority && !(priority == "high" || priority == "medium" || priority == "low") )
        raise UdaciListErrors::InvalidPriorityValue, priority + " is not a valid priority"
    end
    value = " ⇧".colorize(:red) if @priority == "high"
    value = " ⇨".colorize(:yellow) if @priority == "medium"
    value = " ⇩".colorize(:blue) if @priority == "low"
    value = "" if !priority
    return value
  end
  def format_date(start_date = nil, end_date = nil)
    # regular expression to test if it is a number
    dates = Chronic.parse(start_date).strftime("%D") if start_date
    dates << " -- " + Chronic.parse(end_date).strftime("%D") if end_date
    dates = "No due date" if !dates
    return dates
  end
end
