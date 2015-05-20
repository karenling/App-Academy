class Response < ActiveRecord::Base
  validates :user_id, :answer_choice_id, presence: true
  validate :respondent_has_not_already_answered_question
  validate :author_cannot_answer_own_question

  belongs_to(
    :answer_choice,
    class_name: 'AnswerChoice',
    foreign_key: :answer_choice_id,
    primary_key: :id
  )

  belongs_to(
    :respondent,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id
  )

  has_one(
    :question,
    through: :answer_choice,
    source: :question
  )

  def author_cannot_answer_own_question
    #make sure that the self.user_id does not equal the author_id of the poll
    if self.question.poll.author_id == self.user_id
      errors[:base] << "You cannot your own poll."
    end
  end

  def respondent_has_not_already_answered_question
    #gets all the responses for this question
    # if Question.find(self.question.id).responses.find_by(user_id: user_id)
    #   errors[:base] << "You have already answered this question."
    # end

    if self.sibling_responses.exists?(user_id: user_id)
      errors[:base] << "You have already answered this question."
    end
  end

  def sibling_responses
    #get the question object for this response
    # question = self.question #question object


    # if self.id != nil
    #   self.question.responses
    #     .where('responses.id <> ?', self.id)
    # else
    #   self.question.responses
    #     .where('responses.id IS NOT NULL')
    # end
    self.question.responses
      .where('CASE WHEN ? IS NOT NULL THEN responses.id <> ?
      ELSE responses.id IS NOT NULL END', self.id, self.id)
  end
end
