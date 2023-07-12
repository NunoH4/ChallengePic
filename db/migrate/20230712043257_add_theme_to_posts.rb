class AddThemeToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :theme, :string
  end
end
