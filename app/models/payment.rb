class Payment < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :groups, join_table: 'groups_payments'

  validates :name, presence: true, length: { maximum: 50 }
  validates :amount, presence: true, numericality: { greater_than: 0, alert: 'must be greater than 0' }
end
