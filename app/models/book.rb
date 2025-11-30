class Book < ApplicationRecord
  has_many :borrowings
  has_many :users, through: :borrowings

  scope :available, -> { where(available: true) }

  def increase_quantity
    self.quantity += 1
    set_availability
  end

  def decrease_quantity
    self.quantity -= 1
    set_availability
  end

  private

  def set_availability
    self.available = quantity.positive?
    save!
  end
end
