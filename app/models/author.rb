class Author < ApplicationRecord
  has_one :book_author
  has_one :name
end
