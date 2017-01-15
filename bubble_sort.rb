def bubble_sort array
  sorted = false
  last_swap = array.length - 2
  while !sorted
  	sorted = true
    array[0..last_swap].each_with_index do |a, i|
      if a > array[i + 1]
        array[i], array[i + 1] = array[i + 1], array[i]
        sorted = false
      end
    end
  end
  return array
end
puts bubble_sort([4,3,78,2,0,2]) # [0,2,2,3,4,78]