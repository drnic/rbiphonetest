class IPhoneRuby::SDK
  IPHONE_SDK_FOLDER = "/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS2.0.sdk/System/Library/Frameworks"
  MACOSX_SDK_FOLDER = "/Developer/SDKs/MacOSX10.5.sdk/System/Library/Frameworks"
  
  def self.platform(platform)
    case platform.to_sym
    when :iphone
      self.new IPHONE_SDK_FOLDER
    when :macosx
      self.new MACOSX_SDK_FOLDER
    end
  end
  
  def self.similar_framework_names(platform_a = :macosx, platform_b = :iphone)
    frameworks_a = self.platform(platform_a).frameworks
    frameworks_b = self.platform(platform_b).frameworks
    frameworks_a & frameworks_b
  end
  
  def self.similar_framework_header_names(framework_name, platform_a = :macosx, platform_b = :iphone)
    header_names_a = self.platform(platform_a).framework_header_names(framework_name)
    header_names_b = self.platform(platform_b).framework_header_names(framework_name)
    header_names_a & header_names_b
  end
  
  def self.similarities(platform_a = :macosx, platform_b = :iphone)
    @platform_a, @platform_b = self.platform(platform_a), self.platform(platform_b)
    self.similar_framework_names(platform_a, platform_b).inject({}) do |mem, framework|
      headers = similar_framework_header_names(framework, 
        platform_a, platform_b)
      mem[framework] = headers.inject({}) do |mem2, header|
        header_path_a = @platform_a.header_path(framework, header)
        header_path_b = @platform_b.header_path(framework, header)
        diff = `diff -u '#{header_path_a}' '#{header_path_b}'`
        mem2[header] = OpenStruct.new(:diff? => (diff != ""))
        mem2
      end
      mem
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
  
  def framework_header_names(framework)
    Dir["#{frameworks_path}/#{framework}.framework/Headers/*.h"].map do |full_path|
      full_path =~ %r{/([^/]+)\.h$}
      $1
    end
  end
  
  def header_path(framework, header)
    File.join frameworks_path, "#{framework}.framework", "Headers", "#{header}.h"
  end
end