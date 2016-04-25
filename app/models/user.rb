class User < ActiveRecord::Base
  # has_secure_password does the following:
  # 1- it adds attribute accessors: password and password_confirmation
  # 2- It adds validatation: password must be present on creation
  # 3- if password confirmation is present, it will make sure its equal to password
  # 4- Password length should be less than or equal to 72 characters
  # 5- it will has the password using Bcrypt and stores the hash digest in the pass_disgest field
  has_secure_password
  has_many :questions, dependent: :nullify
  has_many :answers,   dependent: :nullify
  has_many :likes, dependent: :nullify
  has_many :liked_questions, through: :likes, source: :question
  has_many :votes, dependent: :destroy
  has_many :voted_questions, through: :votes, source: :question

  attr_accessor :abc

  validates :first_name, presence: true
  validates :last_name, presence: true

  VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, uniqueness: true, presence: true, format: VALID_EMAIL_REGEX

  def full_name
    "#{first_name} #{last_name}"
  end

  def generate_password_reset_data
    generate_password_reset_token
    self.password_reset_requested_at = Time.now
    save
  end

  def password_reset_expired?
    password_reset_requested_at < 60.minutes.ago
  end

  private

  def generate_password_reset_token
    begin
      self.password_reset_token = SecureRandom.hex(32)
  end while User.exists?(password_reset_token: self.password_reset_token)
end
end
