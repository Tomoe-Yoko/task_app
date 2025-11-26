class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, length: { maximum: 500 }
  validate :deadline_cannot_be_in_the_past

  def deadline_cannot_be_in_the_past
    return if deadline.present? && deadline < Time.zone.today

    errors.add(:deadline, "締め切り日は今日以降の日付にしてください")
  end
end
