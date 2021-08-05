class Task < ApplicationRecord
  belongs_to :category
  belongs_to :user
  validates :name, :description, :due_at, presence: true
end
