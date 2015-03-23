class AddConfirmedToAnswers < ActiveRecord::Migration
  def up
    add_column :answers, :confirmed, :boolean, default: false

    answers = Answer.all
    for answer in answers
      if answer.confirmed.nil?
        answer.confirmed == false
      end
    end

  end

  def down
    remove_column :answers, :confirmed
  end


end
