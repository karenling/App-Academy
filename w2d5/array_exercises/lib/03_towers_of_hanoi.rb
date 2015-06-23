def move(towers, from, to)
  begin
    if towers[from].empty?
      raise ArgumentError
    end
    unless from.is_a?(Integer) && to.is_a?(Integer)
      raise ArgumentError
    end
    unless from < 3  && to < 3
      raise ArgumentError
    end
    if !towers[to].empty? && towers[from].last > towers[to].last
      raise ArgumentError
    end

    return towers
  end
  towers[to] << towers[from].pop
  towers
end

def create_towers(num = 3)
  tower1 = (1..num).to_a.reverse
  [tower1, [], []]
end

def game
  #towers = [[], [], []]
  puts "How many discs should we start with?"
  discs_number = gets.chomp
  towers = create_towers(discs_number)

  until won?(towers, discs_number)
    begin

      puts "From which tower would you like to pull?"
      starting_tower = gets.chomp
      puts "To which tower will the disk go?"
      ending_tower = gets.chomp
      towers = move(towers, starting_tower, ending_tower)
    rescue
      puts "Your arguments were invalid. Please try again."
      retry
    end

  end

end

def won?(towers, number_of_disks)
  (towers[2].count == number_of_disks) ||
  (towers[1].count == number_of_disks)
end
