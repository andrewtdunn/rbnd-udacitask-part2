class TodoItem
  include Listable
  attr_reader :description, :due, :priority, :type

  def initialize(description, type, options={})
    @description = description
    @due = options[:due]
    @priority = options[:priority]
    @type = type
  end
  def details
    format_description(@description) + "due: " +
    format_date(@due) +
    format_priority(@priority)
  end
  def change_priority(priority)
    if (priority && !(priority == "high" || priority == "medium" || priority == "low") )
        raise UdaciListErrors::InvalidItemType, priority + " is not a valid priority"
    end
    @priority = priority
  end
end
