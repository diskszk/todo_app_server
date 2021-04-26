class Task < ApplicationRecord
  validates :title, presence: true
  validates :contents, length: { maximum: 50 }

  belongs_to :user
end