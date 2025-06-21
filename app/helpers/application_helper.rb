module ApplicationHelper
  def active_class_by_title(title)
    'active' if @title == title 
  end
end
