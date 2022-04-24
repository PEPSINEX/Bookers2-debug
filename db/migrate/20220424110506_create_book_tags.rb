class CreateBookTags < ActiveRecord::Migration[6.1]
  def change
    create_table :book_tags do |t|
      t.references :book, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
