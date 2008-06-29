require 'config/requirements'
require 'config/hoe' # setup Hoe + all gem configuration
require "fileutils"

Dir['tasks/**/*.rake'].each { |rake| load rake }

desc "Generate some wiki pages"
task :wiki => ["wiki:init", "wiki:platform_diff"]

namespace :wiki do
  task :init do
    FileUtils.mkdir_p "wiki"
  end
  
  desc "Generate a list of framework/header files available on both OSX and iPhone"
  task :platform_diff do
    require 'iphoneruby'
    similarities = IPhoneRuby::SDK.similarities
    # note: textile format for github.com wiki pages
    File.open("wiki/platform-differences.txt", "w") do |f|
      similarities.keys.sort.each do |framework|
        headers = similarities[framework]
        f << "* #{framework}\n"
        headers.keys.sort.each do |header|
          diff = similarities[framework][header]
          difference = diff.diff? ? "*some differences*" : ""
          f << "** #{header}.h #{difference}\n"
        end
        f << "\n"
      end
    end
  end
end