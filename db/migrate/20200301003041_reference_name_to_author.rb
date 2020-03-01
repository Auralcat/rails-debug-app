class ReferenceNameToAuthor < ActiveRecord::Migration[6.0]
  def change
    change_table :names do |t|
      t.belongs_to :author
    end
  end
end
