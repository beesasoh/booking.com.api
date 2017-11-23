class CreateCities < ActiveRecord::Migration[5.1]
  def change
    create_table :cities do |t|
      t.string :name
      t.integer :country_id
      t.string :city_id
      t.timestamps
    end
    add_index :cities, :country_id
  end
end
