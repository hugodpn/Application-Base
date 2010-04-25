# == Schema Information
# Schema version: 20100418035017
#
# Table name: permissions
#
#  id               :integer         not null, primary key
#  permissible_id   :integer
#  permissible_type :string(255)
#  action           :string(255)
#  granted          :boolean
#  created_at       :datetime
#  updated_at       :datetime
#

class Permission < ActiveRecord::Base
  # uncomment any of the following lines which is relevant to your application,
  # or create your own with the name of the model which acts_as_permissible.
  #belongs_to :user
  
  belongs_to :role
  
  belongs_to :permissible, :polymorphic => true
  
  validates_presence_of :permissible_id, :permissible_type, :action
  validates_format_of :action, :with => /^[a-z_]+$/
  validates_numericality_of :permissible_id
  validates_uniqueness_of :action, :scope => [:permissible_id,:permissible_type]
  
  def to_hash
    self.new_record? ? {} : {self.action => self.granted}
  end


#  PERMISSIONS = {
#    :model => {
#      :general => {
#        :title => "Show model general something...",
#        :columns => ["show", "edit", "create"],
#        :rows => ["uno", "dos", "tres"]
#      },
#      :general_two => {
#        :title => "Show model general_two something...",
#        :columns => ["edit", "create"],
#        :rows => ["uno", "dos", "tres"]
#      }
#    }, # "model_general_show_uno"
#    :model_two => {
#      :general => {
#        :title => "Show model_two general something...",
#        :columns => ["show", "edit", "create"],
#        :rows => ["uno", "dos", "tres"]
#      }
#    }
#  }


  PERMISSIONS = {
    :articles => {
      :article => {
        :title => "Articles Permissions",
        :columns => ["can"],
        :rows => ["listing", "view", "update", "create", "destroy"]
      }
    }, 
    :users => {
      :user => {
        :title => "Users Permissions",
        :columns => ["can"],
        :rows => ["listing", "view", "update", "create", "destroy"]
      }
    }
  }

end
