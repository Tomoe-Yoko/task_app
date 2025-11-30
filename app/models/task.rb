class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, length: { maximum: 500 }
  validates :deadline, presence: true
  validate :deadline_cannot_be_in_the_past
  # 期限日のバリデーション
  def deadline_cannot_be_in_the_past
    return if deadline.blank?
    return if deadline >= Time.zone.today

    errors.add(:deadline, "は今日以降の日付にしてください")
  end
  # ソート機能
  scope :updated, -> { order(updated_at: :desc) }
  scope :latest, -> { order(deadline: :asc) }
  scope :created, -> { order(created_at: :desc) }
  # ステータス機能
  enum :status, { not_started: 0, doing: 1, done: 2 }
  scope :not_started, -> { where(status: :not_started) }
  scope :doing, -> { where(status: :doing) }
  scope :done, -> { where(status: :done) }
  # Ex:- scope :active, -> {where(:active => true)}
end
