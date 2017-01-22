class LinkedList
  class Node
  attr_accessor :next, :value
    def initialize(value)
      @value = value
      @next = nil
    end
  end

  def initialize
    @head = nil
    @size = 0
  end
  
  def append(value)
    if @head == nil
      @head = Node.new(value)
    else
      current_node = @head
      until current_node.next == nil
        current_node = current_node.next
      end
      current_node.next = Node.new(value)
    end
    @size += 1
  end

  def prepend(value)
    old_head = @head
    @head = Node.new(value)
    @head.next = old_head
    @size += 1
  end

  def size
    return @size
  end

  def head
    return @head.value
  end

  def tail
    current_node = @head
    until current_node.next == nil
      current_node = current_node.next
    end
    return current_node.value 
  end

  def at(index)
    n = 0
    current_node = @head
    until current_node == nil
      if n == index
        return current_node.value
      else
        current_node = current_node.next
        n += 1
      end
    end
    return nil
  end

  def pop
    current = 0
    current_node = @head
    if @size == 0
      return nil
    elsif @size == 1
      tail = @head.value
      @head = nil
      return tail
    else
      until current > @size
        current += 1
        if current == @size - 1
          tail = current_node.next.value
          current_node.next = nil
          @size -= 1
          return tail
        end
        current_node = current_node.next
      end
    end
  end

  def contains?(value)
    current_node = @head
    until current_node == nil
      if current_node.value == value
        return true
      else
        current_node = current_node.next
      end
    end
    return false
  end

  def find(value)
    current_index = 0
    current_node = @head
    until current_index == @size
      if current_node.value == value
        return current_index
      else
        current_node = current_node.next
        current_index += 1
      end
    end
    return nil
  end

  def to_s
    view = ""
    current_node = @head
    until current_node == nil
      view += "( #{current_node.value} ) -> "
      current_node = current_node.next
    end
    view += "nil"
  end

  def insert_at(index, value)
    if index == 0
      prepend(value)
      return nil
    end
    n = 0
    current_node = @head
    until current_node == nil
      if n == index - 1
        next_node = current_node.next
        current_node.next = Node.new(value)
        current_node = current_node.next
        current_node.next = next_node
        @size += 1
        return nil
      end
      n += 1
      current_node = current_node.next
    end
  end

  def remove_at(index)
    if index == @size
      return nil
    elsif index == 0
      @head = @head.next
    end
    n = 0
    current_node = @head
    until current_node == nil
      if n == index - 1
        delete_node = current_node.next
        next_node = delete_node.next
        current_node.next = next_node
        @size -= 1
        return nil
      end
      n += 1
      current_node = current_node.next
    end
  end
end

=begin tests

list = LinkedList.new
list.append(7)
list.append(8)
list.append(99)
list.prepend(9)
list.prepend(1)
p "List size: #{list.size}"
p "List head: #{list.head}"
p "List tail: #{list.tail}"
p list.at(0) # 1
p list.at(1) # 9
p list.at(2) # 7
p list.at(3) # 8
p list.at(4) # 99
puts "Popping"
p list.pop
p list.size
puts "Popping"
p list.pop
p list.size
p "List tail: #{list.tail}"
p "List contains 9: #{list.contains?(9)}"
p "List contains 99: #{list.contains?(99)}"
p list.find(8)
p list.to_s
list.insert_at(0, 50)
p list.to_s
list.insert_at(3, 33)
p list.to_s
p list.size
list.remove_at(0)
p list.to_s
=end
