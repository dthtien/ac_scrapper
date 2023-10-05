class Quote < ApplicationRecord
  belongs_to :user

  validates :division, :storey, presence: true
end
