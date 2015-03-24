class AddConfirmedToAnswers < ActiveRecord::Migration
  def up
    
    add_column :answers, :best, :boolean, default: false

    answers = Answer.all
    for answer in answers
      if answer.best.nil?
        answer.best == false
      end
    end

  end

  def down
    remove_column :answers, :best
  end


end
