class CreateBookRatings < ActiveRecord::Migration[6.1]
  def change
    create_table :book_ratings do |t|
      t.references :book, null: false, foreign_key: true, unique: true
      t.float :rate

      t.timestamps
    end
  end
end
