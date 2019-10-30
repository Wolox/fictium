# Fictium

This gem is a documentation helper. The goal of this gem is, by adding small modifications into your existing tests,
you can then transform it into easy REST documentation.

For the initial release, the support is focused explicitly on generating documentation from [RSpec](https://rspec.info/) tests, and generate an [OpenAPI](https://github.com/OAI/OpenAPI-Specification) [V3.0.2](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.2.md) Document.

Future versions may allow to export to other OpenAPI versions, or even API Bluepinrt formats.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'fictium'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fictium

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/fictium. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).


## About

This project was developed by [Ramiro Rojo](https://github.com/holywyvern).
Maintainers: [Ramiro Rojo](https://github.com/holywyvern)
Contributors: None (for now...)
![Wolox](https://raw.githubusercontent.com/Wolox/press-kit/master/logos/logo_banner.png)


## Code of Conduct

Everyone interacting in the Fictium project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/fictium/blob/master/CODE_OF_CONDUCT.md).
