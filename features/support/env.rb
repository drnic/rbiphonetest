require File.dirname(__FILE__) + "/../../lib/rbiphonetest"

gem 'cucumber'
require 'cucumber'
gem 'rspec'
require 'spec'

begin
  require 'rubigen'
rescue LoadError
  require 'rubygems'
  require 'rubigen'
end
require 'rubigen/helpers/generator_test_helper'
include RubiGen::GeneratorTestHelper

SOURCES = Dir[File.dirname(__FILE__) + "/../../*_generators"].map do |f|
  RubiGen::PathSource.new(:test, File.expand_path(f))
end