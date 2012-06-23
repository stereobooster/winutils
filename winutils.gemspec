# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "winutils/version"

Gem::Specification.new do |s|
  s.name        = "winutils"
  s.version     = Winutils::VERSION
  s.authors     = ["sterebooster"]
  s.email       = ["stereobooster@gmail.com"]
  s.homepage    = "http://github.com/stereobooster/winutils"
  s.summary     = %q{A collection of useful windows utilities}
  s.description = %q{A collection of useful windows utilities. Motivation behind this gem: I like bundler and how it's easy to manage dependencies with it, I want something similar for windows utilities.}

  s.files         = `git ls-files`.split("\n")
  s.require_paths = ["lib"]
end
