class CreateBooksUserBookComments < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string  'asin',            default: '',              null: false
      t.string  'title',           default: '',              null: false
      t.string  'image_url',       default: '',              null: false
      t.string  'detail_page_url', default: '', limit: 1020, null: false
      t.timestamps
    end
    add_index :books, :asin

    create_table :user_books do |t|
      t.integer 'user_id', null: false
      t.integer 'book_id', null: false
      t.timestamps
    end
    add_index :user_books, :user_id
    add_index :user_books, :book_id

    create_table :user_book_comments do |t|
      t.integer 'user_book_id', null: false
      t.date    'date'
      t.string  'comment',      default: '', null: false
      t.timestamps
    end
    add_index :user_book_comments, :user_book_id
  end
end
