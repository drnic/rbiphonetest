require File.dirname(__FILE__) + '/spec_helper'

require "<%= class_name %>.bundle"
OSX::ns_import :<%= class_name %>

describe OSX::<%= class_name %> do
  
  it "should exist" do
    OSX::<%= class_name %>
  end
  
end