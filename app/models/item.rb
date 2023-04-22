class Item < ApplicationRecord
  scope :search, ->(query) { where('title LIKE ?', "%#{query}%") }
end
