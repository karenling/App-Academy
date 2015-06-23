def rps(user_choice)
  choices = ["Rock", "Paper", "Scissors"]
  computer_choice = choices[rand(3)]

  if user_choice == computer_choice
    return "#{computer_choice}, Draw"
  elsif user_choice == "Rock" && computer_choice != "Paper"
    return "#{computer_choice}, Win"
  elsif user_choice == "Paper" && computer_choice != "Scissors"
    return "#{computer_choice}, Win"
  elsif user_choice == "Scissors" && computer_choice != "Rock"
    return "#{computer_choice}, Win"
  else
    return "#{computer_choice}, Lose"
  end


end


p rps("Rock") # => "Paper, Lose"
p rps("Scissors") # => "Scissors, Draw"
p rps("Scissors") # => "Paper, Win"
