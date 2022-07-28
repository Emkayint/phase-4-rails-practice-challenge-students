class Student < ApplicationRecord
  belongs_to :instructor
  validates :name, presence: true
  validate :must_be_greater_than_18

  def must_be_greater_than_18
    if age < 18
      errors.add(:age, "invalid age")
    end
  end
end
