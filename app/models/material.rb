# == Schema Information
#
# Table name: materials
#
#  id          :integer          not null, primary key
#  description :text
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Material < ApplicationRecord
  validates :name, :uniqueness => { :case_sensitive => false }

  #Direct Associations
  has_many(:purchases, { :class_name => "Purchase", :foreign_key => "material_id", :dependent => :destroy })
  has_many(:ingredients, { :class_name => "Ingredient", :foreign_key => "material_id", :dependent => :destroy })  

  #Indirect Associations
  has_many(:users, { :through => :purchases, :source => :user })
  has_many(:recipes, { :through => :ingredients, :source => :recipe })

end
