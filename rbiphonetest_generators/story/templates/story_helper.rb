require "rubygems"
require "spec/story"
require "ruby-debug"

require "osx/cocoa"
$:.unshift File.dirname(__FILE__) + "/../build/bundles"

dir = File.dirname(__FILE__)
Dir[File.expand_path("#{dir}/steps/*.rb")].uniq.each do |file|
  require file
end

def run_local_story(filename, options={})
  run File.join(File.dirname(__FILE__), filename), options
end