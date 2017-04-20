class Friendship < ActiveRecord::Base
  belongs_to :user, foreign_key: :friend_id
  after_create do |user|
    return if Friendship.find(:first, conditions: { friend_id: user.user_id })
    Friendship.create(user_id: user.friend_id, friend_id: user.user_id)
  end
  after_update do |user|
    mutual = Friendship.find(:first, conditions: { friend_id: user.user_id })
    mutual.is_pending = is_pending unless mutual.nil?
  end
  after_destroy do |user|
    mutual = Friendship.find(:first, conditions: { friend_id: user.user_id })
    mutual.destroy unless mutual.nil?
  end
end
