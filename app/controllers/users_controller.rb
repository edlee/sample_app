class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    @title = @user.name
  end
  
  def new
    @user = User.new
    @title = "Sign up"
  end
  
  def create
    #debug to see params but page will not render
    #raise params[:user].inspect
    @user = User.new(params[:user])
    if @user.save
      #redirect_to user_path(@user)
      #shorter idom because rails infers user_path
      flash[:success] = "Welcome to Sample App"
      redirect_to @user
    else
      @title = "Sign up"
      render :new
    end
  end

end
