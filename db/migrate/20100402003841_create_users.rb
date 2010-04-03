class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string    :login,               :null => false 
      t.string    :email,               :null => false
      t.string    :crypted_password,    :null => false
      t.string    :password_salt,       :null => false
      t.string    :persistence_token,   :null => false 


      t.integer   :login_count,         :null => false, :default => 0 
      t.integer   :failed_login_count,  :null => false, :default => 0 
      t.datetime  :last_request_at  
      t.datetime  :current_login_at  
      t.datetime  :last_login_at     
      t.string    :current_login_ip  
      t.string    :last_login_ip  

      t.boolean   :is_admin, :default => false
      t.timestamps
    end


    admin_usr = User.create(:password_confirmation=>"adminadmin", :password=>"adminadmin",
      :login=>"admin", :email=>"admin@dhpn.com")
    admin_usr.is_admin = true
    admin_usr.save

    usr = User.create(:password_confirmation=>"useruser", :password=>"useruser",
      :login=>"user", :email=>"user@dhpn.com")
    usr.is_admin = false
    usr.save

  end

  def self.down
    drop_table :users
  end
end
