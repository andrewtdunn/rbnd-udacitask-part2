class UdaciList
  attr_reader :title, :items

  def initialize(options={})
    @title =  options[:title] ? options[:title] : "Untitled List"
    @items = []
  end
  def add(type, description, options={})
    type = type.downcase
    if !(type == "todo" || type == "event" || type == "link")
      raise UdaciListErrors::InvalidItemType, type + " is not a valid item type."
    end
    @items.push TodoItem.new(description, type, options) if type == "todo"
    @items.push EventItem.new(description, type, options) if type == "event"
    @items.push LinkItem.new(description, type, options) if type == "link"
  end
  def delete(*args)
    args.each do |index|
      if ( index > @items.size )
        raise UdaciListErrors::IndexExceedsListSize, index.to_s +  " is greater than the number of items."
      end
    end
    @items.delete_if.with_index { |_, index| args.include? index +1 }
  end
  def all
    print_table(@items)
  end
  def filter(item_type)
    if !(item_type == "todo" || item_type == "event" || item_type == "link")
      raise UdaciListErrors::InvalidItemType, item_type + " is not a valid item type."
    end
    print_table(@items.select {|item| item.type == item_type})
  end
  def print_table(arr)
    rows = []
    title = "-" * @title.length +  @title + "-" * @title.length
    arr.each_with_index do |item, position|
      rows << ["#{position + 1}", "#{item.details}", "#{item.type}"]
    end
    table = Terminal::Table.new :title => title, :rows => rows, :headings => ["Item #", "Description", "Type"]
    puts table
  end
  def change_priority(index, new_priority)
    if @items[index-1].type != "todo"
      raise UdaciListErrors::InvalidItemType, @items[index-1].type  + " items do not have priority listings."
    end
    @items[index-1].change_priority(new_priority)
  end
end
