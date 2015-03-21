class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.integer :user_id
      t.integer :friend_id
      t.boolean :user_confirmed
      t.boolean :friend_confirmed

      t.timestamps
    end
  end
end
