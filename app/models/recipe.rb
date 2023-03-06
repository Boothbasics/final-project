# == Schema Information
#
# Table name: recipes
#
#  id                :integer          not null, primary key
#  image             :string
#  ingredients_count :integer
#  instructions      :text
#  name              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  user_id           :integer
#
class Recipe < ApplicationRecord
  validates :name, :uniqueness => { :case_sensitive => false }  

  #Direct Associations
  belongs_to(:user, { :class_name => "User", :foreign_key => "user_id" })
  has_many(:ingredients, { :class_name => "Ingredient", :foreign_key => "recipe_id", :dependent => :destroy })

end
