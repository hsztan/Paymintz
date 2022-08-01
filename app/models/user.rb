class User < ApplicationRecord
  has_many :payments
  has_many :groups
end
