class Transfer < ActiveRecord::Base
  validates :user_id, presence: true
  validates :action, presence: true
end
