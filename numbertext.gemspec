Gem::Specification.new do |s|
  s.name = "numbertext"
  s.version = "0.1.0"

  s.required_ruby_version = '>= 2.3'
  s.require_paths = ["lib"]
  s.authors = ["Sergey Korolev"]
  s.email = "zumkorn@gmail.com"
  s.files         = `git ls-files`.split($/)
  s.test_files    = s.files.grep(%r{^(spec)/})
  s.homepage = "https://github.com/zumkorn/numbertext"
  s.rubygems_version = "2.5.1"
  s.summary = "From Numbers to Number Names"

  s.add_development_dependency 'rspec'
end