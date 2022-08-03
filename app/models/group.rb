class Group < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :payments, join_table: 'groups_payments'

  validates :name, presence: true, length: { maximum: 50 }
  validates :icon, presence: true, length: { maximum: 100 }

  def transactions_total
    payments.sum(:amount)
  end
end
