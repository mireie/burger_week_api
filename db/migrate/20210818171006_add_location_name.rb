class AddLocationName < ActiveRecord::Migration[6.1]
  def change
    add_column :burgers,:location, :string
  end
end