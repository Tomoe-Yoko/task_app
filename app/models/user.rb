class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tasks, dependent: :destroy # user.destroy した時に user.tasks も一緒に消える仕様
  enum :role, { general: 0, admin: 1 }
  before_update :ensure_last_admin_not_changed_to_general
  before_destroy :ensure_at_least_one_admin, if: :admin?

  private

  def ensure_last_admin_not_changed_to_general
    return unless role_changed? && role_was == "admin" && User.admin.one?

    errors.add(:base, "最低1人は管理者が必要です。一般ユーザーに変更できません。")
    throw :abort
  end

  def ensure_at_least_one_admin
    return unless User.admin.one?

    errors.add(:base, "最低1人は管理者が必要です。削除できません。")
    throw :abort
  end
end
