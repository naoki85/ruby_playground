class CreateUserBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :user_books do |t|
      t.integer 'user_id',                null: false
      t.string  'asin',      default: '', null: false
      t.string  'title',     default: '', null: false
      t.string  'image_url', default: '', null: false
      t.timestamps
    end
    add_index :user_books, :user_id
    add_index :user_books, :asin
  end
end
