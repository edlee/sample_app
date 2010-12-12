class PagesController < ApplicationController
  def home
    @title = "Home"
  end

  def contact
    @title = "Contact"
  end
  
  def about
   @title = "About"
  end
  
  def help
    @title = "Help"
  end
  
  def about2
   @title = "About2"
  end
  
  def testpage
   @title = "TestPage"
  end

end
