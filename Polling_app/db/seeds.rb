# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


ActiveRecord::Base.transaction do

  User.create(user_name: 'Carlos')
  User.create(user_name: 'Karen')

  Poll.create(title: 'Lunch places', author_id: 1)

  Question.create(
    question: 'What\'s your favorite lunch place?',
    poll_id: 1)
  Question.create(
    question: 'What\'s your favorite color?',
    poll_id: 1)

  AnswerChoice.create(answer_choice: 'falafel', question_id: 1)
  AnswerChoice.create(answer_choice: 'burrito', question_id: 1)
  AnswerChoice.create(answer_choice: 'rice', question_id: 1)

  AnswerChoice.create(answer_choice: 'yellow', question_id: 2)
  AnswerChoice.create(answer_choice: 'green', question_id: 2)
  AnswerChoice.create(answer_choice: 'red', question_id: 2)

  Response.create(user_id: 2, answer_choice_id: 3)

end
