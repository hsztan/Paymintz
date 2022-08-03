class Group < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :payments, join_table: 'groups_payments'

  def transactions_total
    payments.sum(:amount)
  end
end
