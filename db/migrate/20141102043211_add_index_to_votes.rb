class AddIndexToVotes < ActiveRecord::Migration
  def change
    add_index :votes, :voter_id
    add_index :votes, :voteable_type
    add_index :votes, [:voter_id, :voteable_id, :voteable_type], unique: true
  end
end
