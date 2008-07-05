require "spec/rake/spectask"

task :default => :spec

task :spec => :compile
  
Spec::Rake::SpecTask.new do |t|
  t.warning = true
end