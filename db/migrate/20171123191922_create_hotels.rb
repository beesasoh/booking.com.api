class CreateHotels < ActiveRecord::Migration[5.1]
  def change
    create_table :hotels do |t|
      t.string :name
      t.integer :city_id
      t.string :latitude
      t.string :longitude
      t.text   :intro_message
      t.integer :number_of_rooms
      t.boolean :creditcard_required, default: false
      t.string :url_link
      t.string :image_url_300
      t.string :image_url_original
      t.timestamps
    end
    add_index :hotels, :city_id
  end
end
