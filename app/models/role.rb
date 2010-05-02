# == Schema Information
# Schema version: 20100427230408
#
# Table name: roles
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Role < ActiveRecord::Base
  has_many :role_memberships, :as => :roleable, :dependent => :destroy
  has_many :roles, :through => :role_memberships, :source => :role
  
  has_many :roleables, :class_name => "RoleMembership", :foreign_key => "role_id", :dependent => :destroy
  has_many :subroles, :through => :roleables, :source => :roleable, :source_type => 'Role'
  #has_many :users, :through => :roleables, :source => :roleable, :source_type => 'User'
  
  validates_uniqueness_of :name
  validates_presence_of :name
  
  acts_as_permissible

end
