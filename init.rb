# inject helper methods
require File.join(File.dirname(__FILE__),"boxover_helper.rb")
ActionView::Base.send(:include, BoxoverHelper)
