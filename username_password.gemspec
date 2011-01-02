# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "username_password/version"

Gem::Specification.new do |s|
  s.name        = "username_password"
  s.version     = UsernamePassword::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Patrick Bacon"]
  s.email       = ["bacon@atomicobject.com"]
  s.summary     = %q{Simple authentication gem to ask user for username/password and save to a file if desired}
  s.description = %q{Simple authentication gem to ask user for username/password and save to a file if desired}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_dependency "highline"
  s.add_dependency "ezcrypto"
  
  s.add_development_dependency "rspec", "~> 2"
  s.add_development_dependency "rake"
end
