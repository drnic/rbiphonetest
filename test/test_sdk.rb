require File.dirname(__FILE__) + '/test_helper.rb'

class TestIPhoneRuby < Test::Unit::TestCase

  def setup
  end
  
  def test_find_iphone_sdk_frameworks
    frameworks = IPhoneRuby::SDK.platform('iphone').frameworks
    assert(frameworks.include?("UIKit"))
  end
  
  def test_similar_framework_names
    similar = IPhoneRuby::SDK.similar_framework_names
    expected = ["AddressBook", "AudioToolbox", "AudioUnit", "CoreAudio", "CoreFoundation", 
        "Foundation", "IOKit", "OpenAL", "QuartzCore", "Security", "SystemConfiguration"]
    assert_equal(expected, similar)
  end
  
  def test_similar_framework_header_names
    similar = IPhoneRuby::SDK.similar_framework_header_names("Foundation")
    expected = ["Foundation", "FoundationErrors", "NSArray", "NSAutoreleasePool", 
        "NSBundle", "NSByteOrder", "NSCalendar", "NSCharacterSet", "NSCoder", "NSData", 
        "NSDate", "NSDateFormatter", "NSDecimal", "NSDecimalNumber", "NSDictionary", 
        "NSEnumerator", "NSError", "NSException", "NSFileHandle", "NSFileManager", 
        "NSFormatter", "NSHTTPCookie", "NSHTTPCookieStorage", "NSIndexPath", 
        "NSIndexSet", "NSInvocation", "NSKeyedArchiver", "NSKeyValueCoding", 
        "NSKeyValueObserving", "NSLocale", "NSLock", "NSMethodSignature", "NSNetServices", 
        "NSNotification", "NSNotificationQueue", "NSNull", "NSNumberFormatter", 
        "NSObjCRuntime", "NSObject", "NSOperation", "NSPathUtilities", "NSPort", 
        "NSProcessInfo", "NSPropertyList", "NSProxy", "NSRange", "NSRunLoop", "NSScanner", 
        "NSSet", "NSSortDescriptor", "NSStream", "NSString", "NSThread", "NSTimer", 
        "NSTimeZone", "NSURL", "NSURLAuthenticationChallenge", "NSURLCache", 
        "NSURLConnection", "NSURLCredential", "NSURLCredentialStorage", "NSURLError", 
        "NSURLProtectionSpace", "NSURLProtocol", "NSURLRequest", "NSURLResponse", 
        "NSUserDefaults", "NSValue", "NSXMLParser", "NSZone"]
    assert_equal(expected, similar)

    similar = IPhoneRuby::SDK.similar_framework_header_names("AddressBook")
    expected = ["ABAddressBook", "ABGroup", "ABMultiValue", "ABPerson", "ABRecord", 
          "AddressBook"]
    assert_equal(expected, similar)
  end
  
  def test_hash_of_similarities_between_two_platforms
    similarities = IPhoneRuby::SDK.similarities
    assert_equal(IPhoneRuby::SDK.similar_framework_names, similarities.keys.sort)
    assert_equal(IPhoneRuby::SDK.similar_framework_header_names("AddressBook"), 
      similarities['AddressBook'])
  end
end
