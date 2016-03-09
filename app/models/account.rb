class Account < ActiveRecord::Base
  belongs_to :users
  validates :user_id, presence: true
  validates :number, presence: true, uniqueness: true
  validates :balance, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
  validates :status, presence: true
end
