# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'activepesel/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.required_ruby_version = '>= 2.7.5'
  s.name        = 'activepesel'
  s.version     = Activepesel::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['voytee']
  s.email       = ['wpasternak@gmail.com']
  s.homepage    = 'http://github.com/voytee/activepesel'
  s.summary     = 'A simple, ORM agnostic, PESEL validator and personal data extractor'
  s.description = 'A simple, ORM agnostic, PESEL (polish personal id number) validator and personal data extractor'
  s.files         = `git ls-files`.split("\n")
  s.require_paths = ['lib']
  s.add_dependency 'activesupport', '>= 3.0'
  s.metadata['rubygems_mfa_required'] = 'true'
end
