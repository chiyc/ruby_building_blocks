module Enumerable
  def my_each
  	if block_given?
  	  for x in self
  	    yield x
  	  end
  	else
  	  self.to_enum
  	end
  end

  def my_each_with_index
  	if block_given?
  	  index = 0
  	  for x in self
        yield x, index
        index += 1 
  	  end
  	else
  	  self.to_enum
  	end
  end

  def my_select
  	if block_given?
      array = []
      for x in self
  	    if yield x
  	  	  array.push x
  	    end
  	  end
  	  return array
    else
      self.to_enum
    end
  end

  def my_all?
    condition = true
  	if block_given?
      for x in self
    	if !yield x
  	      condition = false
  	    end
  	  end
  	else
  	  for x in self
  	  	if !x
	  	  condition = false
	  	end
      end
    end
    return condition
  end

  def my_any?
    condition = false
    if block_given?
      for x in self
        if yield x
          condition = true
        end
      end
    else
      for x in self
      	if x
      	  condition = true
      	end
      end
    end
    return condition
  end

  def my_none?
    condition = true
    if block_given?
      for x in self
        if yield x
          condition = false
        end
      end
    else
      for x in self
        if x
          condition = false
        end
      end
    end
    return condition
  end

  def my_count match=nil
    count = 0
    if block_given?
      for x in self
        if yield x
          count += 1
        end
      end
    else
      for x in self
        if match && match == x
          count += 1
        elsif match == nil
          count += 1
        end
      end
    end
    return count
  end

  def my_map *args
    array = []
    if args.length == 1
      proc = args[0]
      for x in self
        array.push(proc.call(x))
      end
      puts "a block was given: #{block_given?}"
      return array
    elsif block_given?
      for x in self
        array.push(yield x)
      end
      return array
    else
      return self.to_enum
    end
  end

  def my_inject *args
    memo = nil
    if args.length == 2
      memo = args[0]
      obj = args[1]
      for x in self
        memo = memo.send(obj, x)
      end
      return memo
    elsif args.length == 1
      if args[0].is_a?(Symbol)
        obj = args[0]
        for x in self
          if memo == nil

            memo = x
          else
            memo = memo.send(obj, x)
          end
        end
        return memo
      else
        memo = args[0]
      end
    end

    if block_given?
      for x in self
        if memo == nil
          memo = x
        else
          memo = yield memo, x
        end
      end
    end
    return memo
  end
end

# testing inspired by ruby-doc.rg/core-2.4.0/Enumerable.html

sample_array = [1, 2, 3, 4, 5]
[1, 2, 3, 4, 5].each { |x| puts x }
[1, 2, 3, 4, 5].my_each { |x| puts x }

puts
[5, 6, 7].my_each_with_index do |x, i|
  puts "#{x} in index #{i}"
end

puts
new_array = sample_array.my_select { |x| x.even? }
puts new_array


puts ["ant", "bear", "cat"].my_any? { |word| word.length >= 4 }
puts ["ant", "bear", "cat"].my_none? { |word| word.length >= 5 }

puts ["hello", 2, 213].my_all?

puts
puts [false, nil, 3].my_none?

puts
ary = [1, 2, 4, 2]
puts ary.my_count(2)

puts ary.my_map { |i| i*i }

def multiply_els array
  puts array.my_inject(:+)
  puts array.my_inject { |sum, n| sum + n }
  puts array.my_inject(2, :*)
  puts array.my_inject(4) { |product, n| product * n }
end

multiply_els(5..10)
puts
puts
myproc = Proc.new do |x|
  x*x
end
puts ary.my_map(myproc) { |x| x + x }