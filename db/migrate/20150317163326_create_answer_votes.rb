class CreateAnswerVotes < ActiveRecord::Migration
  def up
    create_table :answer_votes do |t|
      t.integer :answer_id
      t.integer :user_id

      t.timestamps
    end
  end
  def down
    drop_table :answer_votes 
  end
end
