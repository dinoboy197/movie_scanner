require 'rake/testtask'

Rake::TestTask.new do |t|
  t.test_files = FileList['test/**/*_test.rb']
  t.warning = true
  t.verbose = true
end

task :default => :test