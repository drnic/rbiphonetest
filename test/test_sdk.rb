require File.dirname(__FILE__) + '/test_helper.rb'

class TestIPhoneRuby < Test::Unit::TestCase

  def setup
  end
  
  def test_find_iphone_sdk_frameworks
    frameworks = IPhoneRuby::SDK.platform('iphone').frameworks
    assert(frameworks.include?("UIKit"))
  end
  
  def test_similar_framework_names
    similar_frameworks = IPhoneRuby::SDK.similar_framework_names
    expected = ["AddressBook", "AudioToolbox", "AudioUnit", "CoreAudio", "CoreFoundation", 
        "Foundation", "IOKit", "OpenAL", "QuartzCore", "Security", "SystemConfiguration"]
    assert_equal(expected, similar_frameworks)
  end
end
