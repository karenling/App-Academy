class Question < ActiveRecord::Base

  has_many(
    :answer_choices,
    class_name: 'AnswerChoice',
    foreign_key: :question_id,
    primary_key: :id
  )

  belongs_to(
    :poll,
    class_name: 'Poll',
    foreign_key: :poll_id,
    primary_key: :id
  )

  has_many(
    :responses,
    through: :answer_choices,
    source: :responses
  )

  def results
    # result_count = {}
    #
    # self.answer_choices.includes(:responses).each do |answer|
    #   result_count[answer.answer_choice] = answer.responses.length
    # end
    #
    # result_count

    all_results = self.answer_choices
      .select('answer_choices.answer_choice, COUNT(*) AS result_count')
      .joins("LEFT OUTER JOIN responses ON responses.answer_choice_id = answer_choices.id")
      .group('answer_choice_id')

    result_hash = {}
    all_results.each do |result|
      result_hash[result.answer_choice] = result['result_count']
    end

    result_hash
    all_results
  end
end


SELECT answer_choices.*, COUNT(answer_choices.answer_choice)
FROM answer_choices
LEFT OUTER JOIN responses ON responses.answer_choice_id = answer_choices.id
GROUP BY answer_choices.id
