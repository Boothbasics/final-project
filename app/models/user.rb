# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string
#  password_digest :string
#  purchases_count :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true
  has_secure_password


  #Direct Associations
  has_many(:purchases, { :class_name => "Purchase", :foreign_key => "user_id", :dependent => :destroy })
  
  #Indirect Associations
  has_many(:materials, { :through => :purchases, :source => :material })

end
