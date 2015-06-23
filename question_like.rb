require_relative 'questions_database.rb'

class QuestionLike
  def self.all
    raw_data = QuestionsDatabase.instance.execute('SELECT * FROM question_likes')
    question_likes = []
    raw_data.each do |row|
      question_likes << QuestionLike.new(row)
    end
    question_likes
  end

  def self.find_by_id(id)
    raw_data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_likes
      WHERE
        question_likes.id = ?
    SQL

    QuestionLike.new(raw_data.first)
  end

  def self.liked_questions_for_user_id(user_id)
    liked_qs = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        questions.*
      FROM
        question_likes
      INNER JOIN
        questions ON question_likes.question_id = questions.id
      WHERE
        question_likes.user_id = ?
    SQL

    liked_qs.map { |q_hash| Question.new(q_hash) }
  end

  def self.num_likes_for_question_id(question_id)
    num_likes = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        COUNT(*) AS num_likes
      FROM
        question_likes
      WHERE
        question_likes.question_id = ?
    SQL

    num_likes[0]['num_likes']
  end

  def self.likers_for_question_id(question_id)
    likers = QuestionsDatabase.instance.execute(<<-SQL, question_id)
      SELECT
        users.*
      FROM
        question_likes
      INNER JOIN
        users ON users.id = question_likes.user_id
      WHERE
        question_likes.question_id = ?
    SQL

    likers.map { |u_hash| User.new(u_hash) }
  end

  def self.most_liked_questions(n)
    questions = QuestionsDatabase.instance.execute(<<-SQL, n)
      SELECT
        questions.*
      FROM
        question_likes
      INNER JOIN
        questions ON question_likes.question_id = questions.id
      GROUP BY question_likes.question_id
      ORDER BY COUNT(*) desc
      LIMIT ?
    SQL

    questions.map { |q_hash| Question.new(q_hash) }
  end
  # attr_reader :id, :question_id, :parent_id, :user_id, :body

  def initialize(attrs = {})
    @id, @question_id, @user_id =
      attrs['id'], attrs['question_id'], attrs['user_id']
  end
end
