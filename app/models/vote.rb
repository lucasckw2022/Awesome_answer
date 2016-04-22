class Vote < ActiveRecord::Base
  belongs_to :question
  belongs_to :user

  validates_inclusion_of :is_up, :in =>[true,false]
  validates :user_id, uniqueness: {scope: :question_id}

  scope :up_count, -> { where(is_up: true).count }
  # def up_count
  #   where(is_up: true).count
  # end

  def self.down_count
    where(is_up: false).count
  end
end
