# == Schema Information
#
# Table name: purchases
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  material_id :integer
#  user_id     :integer
#
class Purchase < ApplicationRecord

  #Direct Associations
  belongs_to(:user, { :required => true, :class_name => "User", :foreign_key => "user_id", :counter_cache => true })
  belongs_to(:material, { :required => true, :class_name => "Material", :foreign_key => "material_id" })
  
end
