class ReferenceBookauthorToBookAndAuthor < ActiveRecord::Migration[6.0]
  def change
    change_table :book_authors do |t|
      t.belongs_to :book
      t.belongs_to :author
    end
  end
end
