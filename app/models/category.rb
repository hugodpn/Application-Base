# == Schema Information
# Schema version: 20100427230408
#
# Table name: categories
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Category < ActiveRecord::Base
  has_many :articles

  validates_presence_of :name
  
end
