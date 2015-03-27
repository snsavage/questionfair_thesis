class AddVotesCountToAnswers < ActiveRecord::Migration

  def up
    add_column :answers, :answer_votes_count, :integer, default: 0

    Answer.reset_column_information
    Answer.all.each do |a| 
      Answer.update_counters a.id, answer_votes_count: a.answer_votes.length
    end

  end

  def down
    remove_column :answers, :answer_votes_count
  end





end
