class Account < ActiveRecord::Base
  belongs_to :users
  validates :users_id, presence: true
  validates :number, presence: true
  validates :balance, presence: true
end