require_relative 'questions_database.rb'

class QuestionFollow
  def self.all
    raw_data = QuestionsDatabase.instance.execute('SELECT * FROM question_follows')
    question_follows = []
    raw_data.each do |row|
      question_follows << QuestionFollow.new(row)
    end
    question_follows
  end

  def self.find_by_id(id)
    raw_data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_follows
      WHERE
        question_follows.id = ?
    SQL

    QuestionFollow.new(raw_data.first)
  end

  def self.followers_for_question_id(question_id)
    followers = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        users.*
      FROM
        question_follows
      INNER JOIN
        users ON question_follows.user_id = users.id
      WHERE
        question_follows.question_id = ?
    SQL

    followers.map { |f_hash| User.new(f_hash) }
  end

  def self.followed_questions_for_user_id(user_id)
    questions = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        questions.*
      FROM
        question_follows
      INNER JOIN
        questions ON question_follows.question_id = questions.id
      WHERE
        question_follows.user_id = ?
    SQL

    questions.map { |q_hash| Question.new(q_hash) }
  end

  def self.most_followed_questions(n)
    questions = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        questions.*
      FROM
        question_follows
      INNER JOIN
        questions ON questions.id = question_follows.question_id
      GROUP BY question_id
      ORDER BY COUNT(*) desc
      LIMIT ?
    SQL

    questions.map { |q_hash| Question.new(q_hash) }
  end

  def initialize(attrs = {})
    @id, @user_id, @question_id =
      attrs['id'], attrs['user_id'], attrs['question_id']
  end
end
