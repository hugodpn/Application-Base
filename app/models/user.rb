# == Schema Information
# Schema version: 20100418035017
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  login              :string(255)     not null
#  email              :string(255)     not null
#  crypted_password   :string(255)     not null
#  password_salt      :string(255)     not null
#  persistence_token  :string(255)     not null
#  login_count        :integer         default(0), not null
#  failed_login_count :integer         default(0), not null
#  last_request_at    :datetime
#  current_login_at   :datetime
#  last_login_at      :datetime
#  current_login_ip   :string(255)
#  last_login_ip      :string(255)
#  is_admin           :boolean
#  is_enabled         :boolean
#  created_at         :datetime
#  updated_at         :datetime
#

class User < ActiveRecord::Base
  acts_as_authentic
  acts_as_permissible

  def has_perm? perm="generic"
    if self.is_admin and self.login == "admin"
      return true
    end
  end

end
