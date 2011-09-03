require 'rubygems'
require 'rake'
$:.unshift 'lib'
require 'rfile'

spec = Gem::Specification.new do |s|
  s.name                 = "rfile"
  s.version              = RFile::VERSION
  s.author               = "Christopher Maujean"
  s.email                = "cmaujean@gmail.com"
  s.homepage             = "http://rubyforge.org/projects/ngslib"
  s.rubyforge_project    = 'ngslib'
  s.platform             = Gem::Platform::RUBY
  s.summary              = "a read only, line oriented, sparse file class"
  s.files                = FileList["{lib,test}/**/*"].to_a
  s.require_path         = "lib"
  s.test_file            = "test/tc_rfile.rb"
  s.extra_rdoc_files     = [ 'lib/LICENSE' ]
  s.has_rdoc             = true
end

