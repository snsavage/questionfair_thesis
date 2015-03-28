class AddMailChimpToUser < ActiveRecord::Migration
  def up
    add_column :users, :mail_chimp, :boolean, default: false


    users = User.all
    for user in users
      if user.mail_chimp.nil?
        user.mail_chimp = false
      end
    end

  end

  def down
    remove_column :user, :mail_chimp
  end


end
