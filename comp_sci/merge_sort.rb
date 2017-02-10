module MergeHelp
  def merge(l, r)
    array = []
    until l.empty? && r.empty?
      if l.empty?
        array << r.shift
      elsif r.empty?
        array << l.shift
      elsif l[0] < r[0]
        array << l.shift
      else
        array << r.shift
      end
    end
    return array
  end
end

def merge_sort a
  include MergeHelp
  if a.length == 1
    return a
  end
  m = a.length/2
  l = merge_sort(a[0...m])
  r = merge_sort(a[m...a.length])
  merge(l, r)
end
