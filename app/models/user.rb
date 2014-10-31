# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)      not null
#  password_digest :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#  session_token   :string(255)      not null
#

class User < ActiveRecord::Base
  attr_reader :password
  
  validates :username, :session_token, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :password_digest, presence: { message: "Password is too short!" }
  
  after_initialize :ensure_session_token
  
  has_many(
    :subs,
    class_name: "Sub",
    foreign_key: :moderator_id,
    primary_key: :id
  )
  
  has_many(
    :posts,
    class_name: "Post",
    foreign_key: :author_id,
    primary_key: :id
  )
  
  def self.generate_session_token
    SecureRandom.urlsafe_base64
  end
  
  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return nil if user.nil?
    if user.is_password?(password)
      user
    else
      nil
    end
  end
  
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
  
  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
  end
  
  private
  
  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end
  
end
