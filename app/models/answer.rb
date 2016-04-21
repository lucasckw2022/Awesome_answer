class Answer < ActiveRecord::Base
  # by having this `belongs_to` in the model we can easily fetch the question
 # for a given answer by running:
 # ans = Answer.find(14)
 # q   = ans.question
 # belongs_to assumes that the `answers` table has a foreign_key called
 # question_id (Rails convention)
  belongs_to :question
  belongs_to :user
  validates :body, presence:true

  def user_full_name
    user ? user.full_name : "Unknown User"
  end

end
