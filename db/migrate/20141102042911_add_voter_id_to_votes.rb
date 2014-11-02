class AddVoterIdToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :voter_id, :integer
    change_column :votes, :voter_id, :integer, null: false
  end
end
