class AddColumnToUserBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :user_books, :detail_page_url, :string, null: false, default: '', limit: 1020, after: :image_url
  end
end
