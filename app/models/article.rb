# == Schema Information
# Schema version: 20100427230408
#
# Table name: articles
#
#  id          :integer(4)      not null, primary key
#  title       :string(255)
#  category_id :integer(4)
#  body        :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Article < ActiveRecord::Base
  belongs_to :category
  validates_presence_of :title

  alias_attribute :name, :title
  
  cattr_reader :per_page
  @@per_page = 5

end
