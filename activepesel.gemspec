$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "activepesel/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "activepesel"
  s.version     = Activepesel::VERSION
  s.platform    = Gem::Platform::RUBY	
  s.authors     = ["voytee"]
  s.email       = ["wpasternak@gmail.com"]
  s.homepage    = "http://github.com/voytee/activepesel"
  s.summary     = %q{A simple, ORM agnostic, Ruby 1.9 compatible PESEL validator and personal data extractor for Rails 3, based on ActiveModel.}
  s.description = %q{A simple, ORM agnostic, Ruby 1.9 compatible PESEL (polish personal id number) validator and personal data extractor for Rails 3, based on ActiveModel.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = Dir["test/**/*"]
  s.require_paths = ["lib"]

  s.add_dependency "rails", ">= 3.0.0"
  s.add_development_dependency "sqlite3"
end
