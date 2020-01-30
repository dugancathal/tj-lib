# coding: utf-8
lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'tj'
  spec.version       = '0.1'
  spec.authors       = ['TJ']

  spec.summary       = ''
  spec.description   = spec.summary
  spec.homepage      = ''

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://gemstash.zp-int.com/private'
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files = Dir['README.md', 'lib/**/*']
  spec.require_paths = ['lib']

  spec.add_development_dependency 'pry-byebug', '~> 3.7.0'
  spec.add_development_dependency 'rspec', '~> 3.9.0'
end
