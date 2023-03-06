class CreateIngredients < ActiveRecord::Migration[6.0]
  def change
    create_table :ingredients do |t|
      t.integer :material_id
      t.string :measure
      t.integer :recipe_id

      t.timestamps
    end
  end
end
