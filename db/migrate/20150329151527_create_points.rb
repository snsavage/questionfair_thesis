class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.belongs_to :user, index: true
      t.string :action
      t.belongs_to :rewardable, index: true
      t.string :rewardable_type
      t.string :description
      t.integer :points

      t.timestamps
    end
  end
end
