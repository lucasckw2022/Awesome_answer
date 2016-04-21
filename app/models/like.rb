class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :question

  #only validates combine user id and question id 
  validates :user_id, uniqueness: {scope: :question_id}
end
