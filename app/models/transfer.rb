class Transfer < ActiveRecord::Base
  validates :user_id, presence: true
  validates :value, presence: true
  validates :origin_account, presence: true, :unless => :destiny_account?
  validates :destiny_account, presence: true, :unless => :origin_account?
  validates :origin_acc_number, presence: true, :unless => :destiny_acc_number?
  validates :destiny_acc_number, presence: true, :unless => :origin_acc_number?
  validates :action, presence: true
  validates :tax, presence: true
end
