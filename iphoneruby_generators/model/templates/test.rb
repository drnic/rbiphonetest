require File.dirname(__FILE__) + '/test_helper'

require "<%= class_name %>.bundle"
OSX::ns_import :<%= class_name %>

class Test<%= class_name %> < Test::Unit::TestCase
  def test_<%= name %>_class_exists
    OSX::<%= class_name %>
  end
end