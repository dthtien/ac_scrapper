class Item < ApplicationRecord
  scope :search, ->(query) { where('title iLIKE ?', "%#{query}%") }
end
