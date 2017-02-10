def bubble_sort_by array
  sorted = false
  last_swap = array.length - 2
  while !sorted
  	sorted = true
    array[0..last_swap].each_with_index do |a, i|
      to_sort = yield(array[i], array[i + 1])
      if to_sort > 0
        array[i], array[i + 1] = array[i + 1], array[i]
        sorted = false
      end
    end
  end
  return array
end

sample = ["hi","hello","hey"]
bubble_sort_by(sample) do |left, right|
  left.length - right.length
end

puts sample
