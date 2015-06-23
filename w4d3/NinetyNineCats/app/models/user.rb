class User < ActiveRecord::Base

  attr_reader :password

  has_many(
    :cats, dependent: :destroy,
    class_name: 'Cat',
    foreign_key: :user_id,
    primary_key: :id
  )

  has_many(
    :cat_rental_requests, dependent: :destroy,
    class_name: 'CatRentalRequest',
    foreign_key: :user_id,
    primary_key: :id
  )

  validates :user_name, :password_digest, presence: true
  validates :user_name, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }

  # after_initialize :populate_session_token



  # def self.create_session_token
  #   SecureRandom.urlsafe_base64
  # end
  #
  # def populate_session_token
  #   self.session_token = User.create_session_token
  # end
  #
  # def reset_session_token!
  #   self.session_token = User.create_session_token
  #   self.save!
  #   self.session_token
  # end
  #

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def User.find_by_credentials(user_name, password)
    user = User.find_by(user_name: user_name)
    if user && user.is_password?(password)
      user
    else
      nil
    end
  end



end
