def caesar_cipher string, shift
  cipher = ""
  string.each_char do |letter|
  	ascii = letter.ord
  	if ascii.between?(65, 90)
  	  cipher += ((((ascii-65) + shift) % 26 ) + 65).chr
  	elsif ascii.between?(97, 122)
  	  cipher += ((((ascii-97) + shift) % 26 ) + 97).chr
  	else
  	  cipher += letter
  	end
  end
  cipher
end

# puts caesar_cipher("What a string!", 5)
