def substrings text, dictionary
  word_count = Hash.new 0
  words = text.split(' ')
  words.each do |word|
  	dictionary.each do |term|
  	  if word.downcase.include?(term)
  	  	word_count[term] += 1
  	  end
  	end
  end
  return word_count
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
puts substrings("Howdy partner, sit down! How's it going?", dictionary)
