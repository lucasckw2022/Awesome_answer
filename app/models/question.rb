class Question < ActiveRecord::Base

  # when using `has_many` you must put a symbol for the associated record in
 # plural format
 # you also should provide the :dependent option which can be either:
 # :destroy: which deletes all the associated answers when the question is deleted
 # :nullify: which makes `question_id` NULL for all associated answers
  # validates_presence_of :title # deprecated > likely to be removed in Rails 5
  # validates :title, :body, presence: true
  has_many :answers, dependent: :destroy
  belongs_to :category
  belongs_to :user

  validates(:title, {presence: true, uniqueness: {message: "must be unique!"}})

  validates :body, length: {minimum: 5}

  validates :view_count, numericality: {greater_than_or_equal_to: 0}

  # VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  # validates :email, format: VALID_EMAIL_REGEX

  # this validates that the combination of title and body must be unique
  # it means that title by itself doesn't have to unique and body by itslef
  # doesn't have to be unique but the combination of the two must be unique
  # validates :title, uniqueness: {scope: :body}

  # we use `validate` to reference a method that will be used for our custom
  # validation
  validate :no_monkey

  after_initialize :set_defaults

  before_validation :titleize_title

  #scope :recent_three, lambda{ order("created_at DESC").limit(3)}
  # this give the same as above
  def self.recent_three
    order("created_at DESC").limit(3)
  end

  def self.search(string)
    ##title.present? && title.downcase.include?("monkey") || body.present? && body.down
    # where(["title ILIKE :term OR body ILIKE :term", {term: "%#{string}%"}])
    where(["title ILIKE? OR body ILIKE?", "%#{string}%", "%#{string}%"])
  end

  #demeter
  def user_full_name
    user ? user.full_name : "Unknown User"
  end

  private

  def set_defaults
    self.view_count ||= 0
  end

  def titleize_title
    self.title = title.titleize
  end

  def no_monkey
    if title.present? && title.downcase.include?("monkey")
      errors.add(:title, "No monkeys!")
    end
  end

end
