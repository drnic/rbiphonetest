class IPhoneRuby::SDK
  IPHONE_SDK_FOLDER = "/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS2.0.sdk/System/Library/Frameworks"

  def self.platform(platform)
    case platform.to_sym
    when :iphone
      self.new IPHONE_SDK_FOLDER
    when :cocoa
      self.new nil
    end
  end
  
  attr_reader :frameworks_path
  
  def initialize(frameworks_path)
    @frameworks_path = frameworks_path
  end
  
  def frameworks
    Dir[frameworks_path + "/*.framework"].map do |full_path|
      full_path =~ %r{/([^/]+)\.framework$}
      $1
    end
  end
end