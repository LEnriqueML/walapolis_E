class RemoveSlugFromIdeas < ActiveRecord::Migration[5.2]
  def change
    remove_column :ideas, :slug, :string
  end
end
