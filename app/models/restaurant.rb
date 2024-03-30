class Restaurant < ApplicationRecord
  belongs_to :genre

  validates :name, presence: true
  validates :address, presence: true
  validates :genre_id, presence: true
end
