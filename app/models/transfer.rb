class Transfer < ActiveRecord::Base
  validates :user_id, presence: true
  validates :value, presence: true
  validates :action, presence: true
end
