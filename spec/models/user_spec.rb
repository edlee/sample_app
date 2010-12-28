require 'spec_helper'

describe User do
  before(:each) do
    @attr = {:name => "Test1 User", :email => "tuser1@example.com"}
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

end












