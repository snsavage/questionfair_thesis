class AddTermsToUser < ActiveRecord::Migration
  def up
    add_column :users, :terms, :boolean, default: false
    users = User.all
    for user in users
      if user.terms.nil?
        user.terms = false
      end
    end
  end

  def down
    remove_column :users, :terms
  end
end
