def shuffle

  puts "What file would you like to shuffle?"
  file_name = gets.chomp
  shuffled_file = File.read(file_name).split("\n").shuffle

  new_file_name ="#{file_name.split(".")[0]}-shuffled.txt"

  File.open(new_file_name, "w") do |f|
    f.puts shuffled_file
  end

end


p shuffle
