$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "virtual_mails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "virtual_mails"
  s.version     = VirtualMails::VERSION
  s.authors     = ["Chen, Yi-Cyuan"]
  s.email       = ["emn178@gmail.com"]
  s.homepage    = "https://github.com/emn178/virtual_mails"
  s.summary     = "A rails plugin that provides a virtual mail box and action mailer delivery method."
  s.description = "A rails plugin that provides a virtual mail box and action mailer delivery method."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "LICENSE.txt", "Rakefile", "README.md", "CHANGELOG.md"]

  s.add_dependency "rails"
  s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3", "~> 1.3.6"
  s.add_development_dependency "bundler", "~> 1.10"
  s.add_development_dependency "rake", "~> 10.0"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "rspec-its"
  s.add_development_dependency "simplecov"
  s.add_development_dependency "coveralls"
  s.add_development_dependency "spring"
  s.add_development_dependency "spring-commands-rspec"
end
