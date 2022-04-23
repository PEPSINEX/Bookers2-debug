class Relationship < ApplicationRecord
  belongs_to :follower, class_name: :User
  belongs_to :followed, class_name: :User

  validate :follow_yourself

  def follow_yourself
    if follower_id == followed_id
      errors.add(:followed, "can not follow yourself")
    end
  end
end
