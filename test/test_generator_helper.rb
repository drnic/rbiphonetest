begin
  require File.dirname(__FILE__) + '/test_helper'
rescue LoadError
  require 'test/unit'
end
require 'fileutils'

# Must set before requiring generator libs.
TMP_ROOT = File.dirname(__FILE__) + "/tmp" unless defined?(TMP_ROOT)
PROJECT_NAME = "my_project" unless defined?(PROJECT_NAME)
app_root = File.join(TMP_ROOT, PROJECT_NAME)
if defined?(APP_ROOT)
  APP_ROOT.replace(app_root)
else
  APP_ROOT = app_root
end
if defined?(RAILS_ROOT)
  RAILS_ROOT.replace(app_root)
else
  RAILS_ROOT = app_root
end

begin
  require 'rubigen'
rescue LoadError
  require 'rubygems'
  require 'rubigen'
end
require 'rubigen/helpers/generator_test_helper'
