# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
$:.push File.join(File.dirname(__FILE__), '.', 'lib')

require 'visual-environments/version'

Gem::Specification.new do |s|
  s.name = %q{visual-environments}
  s.version = VisualEnvironments::VERSION
  s.platform    = Gem::Platform::RUBY
  s.licenses = ["MIT"]

  s.authors = ["Zachery Moneypenny, David van Leeuwen"]
  s.email = %q{whazzmaster@gmail.com}
  s.homepage = %q{http://github.com/madrailers/visual-environments}
  s.summary = %q{Automatic visual, in-browser cues about your current environment}
  s.description = %q{This gem provides a configurable means for showing, via an updated <title> tag or CSS corner banner, what the current runtime environment is (development, staging, test, etc.)  This functionality is never enabled for production, and for all other environments you can exclude specific ones.}

  s.add_dependency "rails"
  s.add_dependency "activesupport"

  s.add_development_dependency "rake"

  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "VERSION",
    "lib/generators/visual_environments/USAGE",
    "lib/generators/visual_environments/install_generator.rb",
    "lib/generators/visual_environments/templates/initializer.rb",
    "lib/visual-environments.rb",
    "spec/spec_helper.rb",
    "spec/test_helper.rb",
    "spec/visual-environments_spec.rb",
    "visual-environments.gemspec"
  ]
  s.test_files = [
    "spec/spec_helper.rb",
    "spec/test_helper.rb",
    "spec/visual-environments_spec.rb"
  ]
  s.require_paths = ["lib"]
end

