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
  
  context "similarities between macosx and iphone platforms" do
    setup do
      # relatively expensive operation as it runs diff over similar header files
      @similarities = IPhoneRuby::SDK.similarities
    end

    should "be a hash of framework => header => diff between headers" do
      assert_equal(IPhoneRuby::SDK.similar_framework_names, @similarities.keys.sort)
      assert_equal(IPhoneRuby::SDK.similar_framework_header_names("AddressBook"), 
        @similarities['AddressBook'].keys.sort)
      assert(!@similarities['Foundation']['NSNull'].diff?)
      # assert_equal("", @similarities['Foundation']['NSNull'].diff)
      
      assert(@similarities['AddressBook']['ABAddressBook'].diff?)
      
      puts @similarities['AddressBook']['ABAddressBook'].methods_diff
    end
    
    should "have some headers the exact same" do
      flattened_similarities =  @similarities.inject({}) do |mem, framework_headers|
        framework, headers = framework_headers
        headers.each do |header_diff|
          header, diff = header_diff
          mem["#{framework}/#{header}"] = diff
        end
        mem
      end
      assert_equal(162, flattened_similarities.size)
      no_diffs = flattened_similarities.reject { |name, sim| sim.diff? }
      assert_equal(153, no_diffs.size)
    end

  end
  
  def test_path_to_header_file
    actual = IPhoneRuby::SDK.platform(:macosx).header_path("Foundation", "NSURL")
    expected = "/Developer/SDKs/MacOSX10.5.sdk/System/Library/Frameworks/Foundation.framework/Headers/NSURL.h"
    assert_equal(expected, actual)
  end
end
