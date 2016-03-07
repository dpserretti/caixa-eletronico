class Transfer < ActiveRecord::Base
  validates :user_id, presence: true
  validates :value, presence: true
  validates :origin_account, presence: true, :unless => :destiny_account?
  validates :destiny_account, presence: true, :unless => :origin_account?
  validates :action, presence: true
end
