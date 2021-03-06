module ApplicationHelper
  
  #Return a title on a per page basis
  def title
    base_title = "Ruby on Rails Tutorial Sample App"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  
  def junktext
    "This is a junk string"
  end
  
  def junktext2
    "Line 1 More junk...."
    "Line 2 More junk...."
    "Line 3 More junk...."
    2+3
    2 == 2
  end
  
  def sample_app_logo
    image_tag("logo.png", :alt => "Sample App", :class => "round", :id => "sample_app_logo")
  end
  
end
