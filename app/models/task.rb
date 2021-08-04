class Task < ApplicationRecord
  belongs_to :category
  validates :name, :description, :due_at, presence: true
end
