require './String.rb'

class User
  attr_accessor :name, :email, :desc
  
  def initialize(attributes = {})
    @name = attributes[:name]
    @email = attributes[:email]
  end
  
  def formatted_email
    "#{@name} <#{@email}>"
  end
  
  def description
    @desc
  end
  
  def secret
    "#{@name.gsub(' ','').jumble}"
  end
  
end