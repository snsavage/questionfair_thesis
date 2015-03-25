class AddGeoToQuestion < ActiveRecord::Migration
  def up
    add_column :questions, :address, :string
    add_column :questions, :city, :string
    add_column :questions, :state, :string
    add_column :questions, :country, :string
    add_column :questions, :latitude, :float
    add_column :questions, :longitude, :float
    add_column :questions, :city_state, :string
  end

  def down
    remove_column :questions, :address
    remove_column :questions, :city
    remove_column :questions, :state
    remove_column :questions, :country
    remove_column :questions, :latitude
    remove_column :questions, :longitude
    remove_column :questions, :city_state
  end

end
