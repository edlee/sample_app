require 'spec_helper'

describe UsersController do
render_views

  describe "GET 'show'" do
    
    before(:each) do
      @user = Factory(:user)
    end
    
    it "should be successful" do
      get :show, :id => @user
      response.should be_success
    end
    
   it "should find the right user" do
     get :show, :id => @user
     assigns(:user).should == @user
   end
   
   it "should have the user name in title" do
     get :show, :id => @user
     response.should have_selector("title", :content => @user.name) 
   end
   
   it "should display user's name in a header" do
      get :show, :id => @user
      response.should have_selector("h1", :content => @user.name)
   end
   
   it "should have a profile image" do
     get :show, :id => @user
     response.should have_selector("h1>img", :class => "gravatar")
   end
    
  end #end GET show

  describe "GET 'new'" do
    it "should be successful" do
      get :new
      response.should be_success
    end
    
    it "should have the right title" do
      get :new
      response.should have_selector("title", :content => "Sign up")
    end
    
  end #end Get new
  
  describe "POST 'create'" do
    
    describe "failure" do
      before(:each) do
        @attr = { :name =>"", :email => "", :password => "",
                  :password_confirmation => "" }
      end
  
      it "should have the right title" do
        post :create, :user => @attr
        response.should have_selector("title", :content => "Sign up")
      end
    
      it "should render the 'new' page" do
        post :create, :user => @attr
        response.should render_template(:new)
      end
    
      it "should not create a user" do
        lambda do
          post :create, :user => @attr
        end.should_not change(User, :count)
      end
        
    end #end failure
    
    describe "success" do
      
      before(:each) do
        @attr = {:name => "New Guy", :email => "newguy@example.com",
                 :password => "newguypass", :password_confirmation => "newguypass" }
      end
      
      it "should create a user" do
        lambda do
          post :create, :user => @attr
        end.should change(User, :count).by(1)
      end
      
      it "should redirect to the user show page" do
        post :create, :user => @attr
        response.should redirect_to(user_path(assigns(:user)))
      end
      
      it "should display a welcome message" do
        post :create, :user => @attr
        flash[:success].should =~ /welcome to sample app/i
      end
      
    end #end success
  
  end #end POST create
  
end
