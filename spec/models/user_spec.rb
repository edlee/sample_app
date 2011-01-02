require 'spec_helper'

describe User do
  before(:each) do
    @attr = {:name => "Test1 User", 
             :email => "tuser1@example.com", 
             :password => "testpass",
             :password_confirmation => "testpass" }
  end
  
  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end
  
  it "should require a name" do
    no_name_user = User.new(@attr.merge(:name => ""))
    no_name_user.should_not be_valid
  end
  
  it "should require an email"  do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end
  
  it "should reject names that are too long" do
    long_name = "a" * 51
    long_name_user = User.new(@attr.merge(:name => long_name))
    long_name_user.should_not be_valid
  end
  
  it "should accept valid email addresses" do
    test_emails  = %w[user1@example.com user.lastname@example.com user-lastname@example.com]
    test_emails << "fn_ln@exam.com"
    test_emails.each do |addr|
      valid_email_user = User.new(@attr.merge(:email => addr))
      valid_email_user.should be_valid
    end
  end
  
  it "should reject invalid email addresses" do
    test_emails = %w[joe harry.com @joe.com joe@exam.com. joe@xam,com]
    test_emails.each do |addr|
      invalid_email_user = User.new(@attr.merge(:email => addr))
      invalid_email_user.should_not be_valid
    end
  end
  
  it "should reject duplicate emails reqardless of case" do
    User.create!(@attr.merge(:email => @attr[:email].upcase))
    dup = User.new(@attr.merge(:email => @attr[:email].downcase))
    dup.should_not be_valid
  end
  
  describe "password validations" do
    it "should require a password" do
      pw_user = User.new(@attr.merge(:password => "", :password_confirmation => ""))
      pw_user.should_not be_valid
    end
    
    it"should be valid with standard test user" do
      pw_user = User.new(@attr)
      #pw_user.password_confirmation ='tes'
      pw_user.should be_valid
    end
    
    it "should require a matching password confirmation" do
      bad_pw = @attr[:password] + "junk"
      #bad_pw = 'testpass'
      pw_user = User.new(@attr.merge(:password_confirmation => bad_pw))
      pw_user.should_not be_valid
      #pw_user = User.new(@attr)
      #pw_user.password_confirmation = bad_pw
      #pw_user.should_not be_valid
    end
    
    it "should reject short passwords" do
      short_pw = 'a' * 5
      pw_user = User.new(@attr.merge(:password => short_pw, :password_confirmation => short_pw))
      pw_user.should_not be_valid
    end
    
    it "should reject long passwords" do
      long_pw = 'a' * 41
      pw_user = User.new(@attr.merge(:password => long_pw, :password_confirmation => long_pw))
      pw_user.should_not be_valid
    end
  end #end of describe password validations

  describe "password encryption" do
    
    before(:each) do
      @user = User.create!(@attr)
    end
    
    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end
    
    it "should have a non blank encrypted password"  do
      @user.encrypted_password.should_not be_blank
    end

    describe "has_password? method" do
      it "should respond to has_password?" do
      @user.should respond_to(:has_password?)
      end
    
      it "should return true if password matches" do
        @user.has_password?(@attr[:password]).should be_true
      end
    
      it "should return false if password does not match" do
        @user.has_password?("#{@attr[:password]}--invalid").should be_false
      end
      
      it "should have a non blank salt" do
        @user.salt.should_not be_blank
      end
    end #end has_password? method
    
    describe "authenticate method" do
      it "should return nil on email/password mismatch" do
        wrong_pw_user = User.authenticate(@attr[:email],"#{@attr[:password]}--invalid")
        wrong_pw_user.should be_nil
      end
      
      it "should return nil if user email is not found" do
        no_user = User.authenticate("not-here-#{@attr[:email]}", @attr[:password])
        no_user.should be_nil
      end
      
      it "should return user on email/password match" do
        pw_user = User.authenticate(@attr[:email], @attr[:password])
        pw_user.should_not be_nil
        pw_user.has_password?(@attr[:password]).should be_true
        pw_user.should == @user        
      end
    end #end authenticate method

  end #end of password encryption
end












