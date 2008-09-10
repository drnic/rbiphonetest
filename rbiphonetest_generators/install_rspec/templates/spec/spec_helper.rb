require "osx/cocoa"

$:.unshift File.dirname(__FILE__) + "/../build/bundles"

bundle_name = '<%= module_name %>'
require "#{bundle_name}.bundle"
OSX::ns_import bundle_name.to_sym
