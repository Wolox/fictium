lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fictium/version'

Gem::Specification.new do |spec| # rubocop:disable Metrics/BlockLength
  spec.name          = 'fictium'
  spec.version       = Fictium::VERSION
  spec.authors       = ['Ramiro Rojo']
  spec.email         = ['ramiro.rojo@wolox.com.ar']

  spec.summary       = 'A gem to generate documentation out of tests.'
  spec.homepage      = 'https://github.com/holywyvern/fictium'
  spec.license       = 'Apache-2.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/holywyvern/fictium'
  spec.metadata['changelog_uri'] = 'https://github.com/holywyvern/fictium/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.6.0'

  spec.add_runtime_dependency 'activesupport',
                              Fictium::RAILS_MIN_VERSION,
                              Fictium::RAILS_MAX_VERSION

  spec.add_development_dependency 'bundler', '~> 2.0'

  spec.add_development_dependency 'byebug'

  spec.add_development_dependency 'brakeman'

  spec.add_development_dependency 'rails',
                                  Fictium::RAILS_MIN_VERSION,
                                  Fictium::RAILS_MAX_VERSION
  spec.add_development_dependency 'rake', '~> 12.3.3'
  spec.add_development_dependency 'rspec', '~> 3.8'
  spec.add_development_dependency 'rubocop', '0.74'
  spec.add_development_dependency 'rubocop-rspec', '1.35.0'
end
