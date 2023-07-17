class RemoveChallengeIdFromPosts < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :challenge_id, :integer
  end
end
