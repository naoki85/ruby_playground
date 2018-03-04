class AddColumnToUserForOmniauth < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :username, :string, default: '', after: :email
    add_column :users, :provider, :string, default: '', after: :locked_at
    add_column :users, :uid, :string, default: '', after: :provider
    add_column :users, :image_url, :string, default: '', after: :uid
    add_index :users, [:provider, :uid]
  end
end
