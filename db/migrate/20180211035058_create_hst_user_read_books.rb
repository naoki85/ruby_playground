class CreateHstUserReadBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :hst_user_read_books do |t|
      t.integer 'user_id',                             null: false
      t.integer 'user_book_id',                        null: false
      t.date    'date'
      t.string  'comment',      default: '',           null: false
      t.timestamps
    end
    add_index :hst_user_read_books, :user_id
    add_index :hst_user_read_books, :user_book_id
  end
end
