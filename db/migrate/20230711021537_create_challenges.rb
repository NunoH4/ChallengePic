class CreateChallenges < ActiveRecord::Migration[6.1]
  def change
    create_table :challenges do |t|

      t.string :theme
      t.timestamps
    end
  end
end
