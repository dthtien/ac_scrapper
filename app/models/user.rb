class User < ApplicationRecord
  has_many :quotes

  validates :name, :email, presence: true
  validates :email, uniqueness: true
end
