def fibs x
  array = []
  for i in 0..x
    if i == 0
      array.push 0
    elsif i == 1
      array.push 1
    else
      array << (array[i-1] + array[i-2])
    end
  end
  return array
end

def fibs_rec n
  if n == 1
    return [0, 1]
  else
    return  fibs_rec(n-1).push(fibs_rec(n-1)[fibs_rec(n-1).length - 1] + fibs_rec(n-1)[fibs_rec(n-1).length - 2])
  end
end
