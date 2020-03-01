class CreateBookAuthors < ActiveRecord::Migration[6.0]
  def change
    create_table :book_authors do |t|
      t.timestamps
    end
  end
end
