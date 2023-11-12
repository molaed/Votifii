class AddStuffToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
    add_column :users, :candidate, :string
    add_column :users, :currentPosition, :string
    add_column :users, :experience, :string
    add_column :users, :education, :string
    add_column :users, :accolades, :string
    add_column :users, :connections, :string
  end
end
