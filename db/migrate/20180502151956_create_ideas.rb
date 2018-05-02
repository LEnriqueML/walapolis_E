class CreateIdeas < ActiveRecord::Migration[5.2]
  def change
    create_table :ideas do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.text :body
      t.text :benefits, array: true, default: []
      t.decimal :initial_cost
      t.decimal :monthly_cost
      t.integer :estimated_time
      t.string :slug

      t.timestamps
    end
  end
end
