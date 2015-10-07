class AddRequiredFieldsForUser < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    add_column :users, :name, :string
    add_column :users, :surname, :string
    add_column :users, :expiration_date, :datetime
  end
end
