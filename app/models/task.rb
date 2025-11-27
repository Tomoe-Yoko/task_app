class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, length: { maximum: 500 }
  validates :deadline, presence: true
  validate :deadline_cannot_be_in_the_past

  def deadline_cannot_be_in_the_past
    return if deadline.blank?
    return if deadline >= Time.zone.today

    errors.add(:deadline, "締め切り日は今日以降の日付にしてください")
  end

  scope :latest, -> { order(deadline: :asc) }
  scope :updated, -> { order(updated_at: :desc) }
  scope :created, -> { order(created_at: :desc) }
end
