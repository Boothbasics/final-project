# == Schema Information
#
# Table name: ingredients
#
#  id          :integer          not null, primary key
#  measure     :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  material_id :integer
#  recipe_id   :integer
#
class Ingredient < ApplicationRecord

  #Direct Associations
  belongs_to(:material, { :required => true, :class_name => "Material", :foreign_key => "material_id" })
  belongs_to(:recipe, { :required => true, :class_name => "Recipe", :foreign_key => "recipe_id", :counter_cache => true })

end
