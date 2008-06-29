require File.dirname(__FILE__) + '/test_helper.rb'

class TestIPhoneRuby < Test::Unit::TestCase

  def setup
  end
  
  def test_find_iphone_sdk_frameworks
    frameworks = IPhoneRuby::SDK.platform('iphone').frameworks
    assert(frameworks.include? "UIKit")
  end
end
