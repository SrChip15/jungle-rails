class User < ActiveRecord::Base
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true, length: {minimum: 2}

  def self.authenticate_with_credentials(email, pwd)
    user_email_normlz = email.strip.downcase
    user = User.find_by(email: user_email_normlz)
    if user && user.authenticate(pwd)
      user
    else
      nil
    end
  end

end
