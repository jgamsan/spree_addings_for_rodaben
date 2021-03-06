# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_addings_for_rodaben'
  s.version     = '1.1.2'
  s.summary     = 'Addings for rodaben'
  s.description = 'Addings models and overrides for rodaben store'
  s.required_ruby_version = '>= 1.8.7'

  s.author    = 'Jose Miguel Gamazo'
  s.email     = 'miguel.gamazo@galiclick.com'
  s.homepage  = 'http://www.spreecommerce.com'

  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'
  s.add_dependency 'spree_core', '>= 1.0.0'

end
