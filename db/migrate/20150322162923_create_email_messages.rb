class CreateEmailMessages < ActiveRecord::Migration
  def change
    create_table :email_messages do |t|
      t.string :name
      t.string :email
      t.string :subject
      t.text   :content
      t.timestamps
    end
  end
end
