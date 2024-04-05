class Vehicle < ApplicationRecord
  validates :type, presence: true
end
