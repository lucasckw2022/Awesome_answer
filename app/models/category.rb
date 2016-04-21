class Category < ActiveRecord::Base
  validates :name, presence:true,uniqueness:true
  has_many :questions,dependent: :nullify
end
