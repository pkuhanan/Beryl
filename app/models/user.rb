class User < ApplicationRecord
  has_secure_password
  has_secure_token
  
  has_many :logbooks
  
  before_validation :set_defaults

  validates :email, uniqueness: true, presence: true
  validates :name, presence: true
  validates :admin, inclusion: { in: [ true, false ] }
  
  def self.valid_login?(email, password)
    user = find_by(email: email)
    user if user && user.authenticate(password)
  end
  
  def invalidate_token
    self.update_columns(token: nil)
  end
  
  private
  
    def set_defaults
      self.admin = false if self.admin.nil?      
    end
end
