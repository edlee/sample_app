require 'spec_helper'

describe "Users" do
  
  describe "Signup" do
    
    describe "failure" do
      
      it "should not create a user" do
        lambda do
          visit signup_path
          fill_in "Name",               :with => ""
          fill_in "Email",              :with => ""
          fill_in "Password",           :with => ""
          fill_in "Confirm Password",   :with => ""
          click_button 'Sign Up'
          response.should render_template('users/new')
          response.should have_selector("div#error_explanation")
        end.should_not change(User, :count)
      end
    end# end failure
    
    describe "success" do
      
      it "should create a new user" do
        lambda do
          visit signup_path
          fill_in "Name",               :with => "Test User"
          fill_in "Email",              :with => "testuser@example.com"
          fill_in "Password",           :with => "testpass"
          fill_in "Confirm Password",   :with => "testpass"
          click_button 'sign up'
          response.should render_template('users/show')
          response.should have_selector('div.flash.success', 
                                        :content => "Welcome")
        end.should change(User, :count).by(1)
      end
      
    end#end success
    
  end #end Signup
end #end Users