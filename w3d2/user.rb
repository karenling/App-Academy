require_relative 'questions_database.rb'

class User
  def self.all
    raw_data = QuestionsDatabase.instance.execute('SELECT * FROM users')
    users = []
    raw_data.each do |row|
      users << User.new(row)
    end
    users
  end

  def self.find_by_id(id)
    raw_data = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        users
      WHERE
        users.id = ?
    SQL

    User.new(raw_data.first)
  end

  def self.find_by_name(fname, lname)
    raw_data = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
        users.fname = ? AND users.lname = ?
    SQL

    users = []
    raw_data.each do |row|
      users << User.new(row)
    end

    users
  end

  attr_accessor :fname, :lname
  attr_reader :id

  def initialize(attrs = {})
    @id, @fname, @lname = attrs['id'], attrs['fname'], attrs['lname']
  end

  def save
    @id = QuestionsDatabase.save('users', @id, instance_variables, params)
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end

  def followed_questions
    QuestionFollower.followed_questions_for_user_id(@id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(@id)
  end

  def average_karma
    average_karma = QuestionsDatabase.instance.execute(<<-SQL, @id)
      SELECT
        CAST(COUNT(question_likes.user_id) AS FLOAT)
          / COUNT(DISTINCT(questions.id)) AS average_karma
      FROM
        questions
      LEFT OUTER JOIN
        question_likes ON question_likes.question_id = questions.id
      WHERE
        questions.user_id = ?
    SQL
    average_karma[0]['average_karma']
  end


  def params
    [@fname, @lname, @id]
  end
end
