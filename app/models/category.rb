class Category < ApplicationRecord
  validates :title, :description, presence: true
  has_many :tasks, dependent: :destroy # ensures destroy action on a category deletes any associated tasks
end
