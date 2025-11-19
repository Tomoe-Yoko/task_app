class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, length: { maximum: 500 }
end
