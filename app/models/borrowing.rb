class Borrowing < ApplicationRecord
  belongs_to :user
  belongs_to :book

  scope :overdue, -> { where("borrowings.created_at < ? AND returned = ?", Date.today - 2.weeks, false) }
  scope :due_today, -> { where("borrowings.created_at >= ? AND borrowings.created_at < ? AND returned = ?", Date.today - 2.weeks, Date.today - 2.weeks + 1.day, false) }
  scope :active, -> { where(returned: false) }
end
