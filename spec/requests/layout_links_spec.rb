require 'spec_helper'

describe "LayoutLinks" do
  describe "GET /layout_links" do
    
    it "should have a Home page at '/'" do
      get '/'
      response.should have_selector('title', :content => "Home")
    end
    
    it "should have a Contact page at '/contact'" do
      get '/contact'
      response.should have_selector('title', :content => "Contact")
    end
    
    it "should have an About page at '/about'" do
      get '/about'
      response.should have_selector('title', :content => "About")
    end
    
    it "should have a Help page at '/help'" do
      get '/help'
      response.should have_selector('title', :content => "Help")
    end
    
    it "should have a Signup page at '/signup'" do
      get '/signup'
      response.should have_selector('title', :content => "Sign up")
    end
    
    it "should go to Home page when logo clicked" do
      visit about_path
      click_link "sample_app_logo"
      response.should have_selector('title', :content => "Home")
    end
    
    it "should have the right links on the layout" do
      visit root_path
      click_link "About"
      response.should have_selector('title', :content => "About")
      
      #must go back to home page to test Sign up button
      #could make this the first test but this proves
      #that at this point you cannot click_link Home page elements
      #Note: click_link param can be text or title or id 
      visit root_path
      click_link "signup_button"
      response.should have_selector('title', :content => "Sign up")    
      
      click_link "Help"
      response.should have_selector('title', :content => "Help")
      click_link "Contact"
      response.should have_selector('title', :content => "Contact")
      click_link "Home"
      response.should have_selector('title', :content => "Home")
    end
    
  end
end
