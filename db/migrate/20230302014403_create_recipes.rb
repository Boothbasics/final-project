class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      t.string :name
      t.text :instructions
      t.string :image
      t.integer :user_id
      t.integer :ingredients_count

      t.timestamps
    end
  end
end
