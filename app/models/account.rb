class Account < ActiveRecord::Base
  belongs_to :users
  validates :users_id, presence: true
  validates :number, presence: true, uniqueness: true
  validates :balance, presence: true, :numericality => { :greater_than => 0 }
  validates :status, presence: true
end
