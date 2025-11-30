# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
ActiveRecord::Base.transaction do
  books = 10.times.map do |i|
    Book.find_or_create_by!(title: "Sample Book #{i + 1}") do |b|
      b.author = "Author #{i + 1}"
    end
  end

  librarians = 10.times.map do |i|
    email = "librarian#{i + 1}@example.com"
    User.find_or_create_by!(email: email) do |u|
      u.role = :librarian
      u.password = "password"
    end
  end

  members = 10.times.map do |i|
    email = "member#{i + 1}@example.com"
    User.find_or_create_by!(email: email) do |u|
      u.role = :member
      u.password = "password"
    end
  end

  books.each_with_index do |book, i|
    member = members[i % members.length]
    borrowed_at = Time.current - (i + 1).days

    Borrowing.find_or_create_by!(book: book, user: member, borrowed_at: borrowed_at)
  end
end
