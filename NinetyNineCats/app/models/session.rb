class Session < ActiveRecord::Base
  validates :session_token, :user_id, presence: true
  # after_initialize :populate_session_token

  def self.create_session_token
    SecureRandom.urlsafe_base64
  end

  # def populate_session_token
  #   self.session_token = Session.create_session_token
  # end

  # def reset_session_token
  #   self.session_token = Session.create_session_token
  #   self.session_token.save!
  #   self.session_token
  # end

end
