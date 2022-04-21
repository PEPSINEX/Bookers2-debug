class CreateFavoriteFromUserToBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :favorite_from_user_to_books do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true

      t.timestamps
    end
    
    add_index :favorite_from_user_to_books, [:user_id, :book_id], unique: true
  end
end
