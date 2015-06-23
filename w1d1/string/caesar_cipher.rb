def caesar_cipher(str, offset)
  str = str.split('').map do |letter|
    if letter == " "
      letter
    else
      position = letter.ord
      new_position = letter.ord + offset

      if new_position > 122
        new_position -= 26
        new_position.chr
      else
        new_position.chr
      end

    end

  end

  str.join
end
p caesar_cipher("hello", 3) # => "khoor"
