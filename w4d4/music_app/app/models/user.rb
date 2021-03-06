class User < ActiveRecord::Base

  attr_reader :password

  validates :email, :password_digest, presence: true
  validates :email, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }
  after_initialize :ensure_session_token
  after_initialize :create_activation_token

  has_many(
    :notes,
    class_name: 'Note',
    foreign_key: :user_id,
    primary_key: :id
  )

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64
  end

  def reset_session_token
    self.session_token = User.generate_session_token
    self.save
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end

  def create_activation_token
    self.activation_token ||= SecureRandom::urlsafe_base64
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)

    if user && user.is_password?(password)
      return user
    else
      return nil
    end
  end

  def activated?
    self.activated
  end

  def self.find_user_by_activation_token(activation_token)
    user = User.find_by(activation_token: activation_token)
  end

end
