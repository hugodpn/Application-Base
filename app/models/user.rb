class User < ActiveRecord::Base
  acts_as_authentic

  def has_perm? perm="generic"
    if self.is_admin and self.login == "admin"
      return true
    end
  end

end