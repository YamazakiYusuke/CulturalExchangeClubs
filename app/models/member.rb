class Member < ApplicationRecord
  # before_destroy :owner_not_destroyed
  belongs_to :user
  belongs_to :group

  validates :user_id, uniqueness: { scope: :group_id }

  # def owner_not_destroyed
  #   if self.group.owner == self.user
  #     errors.add :base, 'オーナーはメンバーから削除できません'
  #     throw :abort
  #   end
  # end
end
