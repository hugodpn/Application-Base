# == Schema Information
# Schema version: 20100418035017
#
# Table name: articles
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  body       :text
#  created_at :datetime
#  updated_at :datetime
#

class Article < ActiveRecord::Base
  belongs_to :category
end
