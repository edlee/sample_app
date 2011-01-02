# == Schema Information
# Schema version: 20110102113557
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#

class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :name,     :presence => true,
                       :length   => {:maximum => 50}
  validates :email,    :presence   => true,
                       :format     => {:with => email_regex},
                       :uniqueness => {:case_sensitive => false}
  validates :password, :presence     => true,
                       :confirmation => true,
                       :length       => {:within => 6..40}
                       
  before_save :encrypt_pw
  
  def has_password?(submitted_pw)
    encrypted_password == encrypt_it(submitted_pw)
  end
  
  #class methods
  def self.authenticate(em, pw)
    user = User.find_by_email(em)
    return user if user == nil
    return user if user.has_password?(pw)
  end
  
  #private section
  private
  
  def encrypt_pw
    self.salt = make_salt if new_record?
    self.encrypted_password = encrypt_it(password)
  end
  
  def encrypt_it(encryptee)
    #fixed salt + variable salt + iteration
    result_hash = secure_hash("@1$5f!%##{salt}--#{encryptee}")
    (1..1011).each do |i|
      result_hash = secure_hash(result_hash)
    end
    return result_hash
  end
  
  def make_salt
    self.salt = secure_hash("#{Time.now.utc}--#{password}")
  end
  
  def secure_hash(str)
    Digest::SHA2.hexdigest(str)
  end
  
end #end class User
