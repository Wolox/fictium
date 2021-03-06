# Fictium

[![Build Status](https://travis-ci.org/Wolox/fictium.svg?branch=development-0-x-x)](https://travis-ci.org/Wolox/fictium) [![Maintainability](https://api.codeclimate.com/v1/badges/52afbf838f92fe260b6e/maintainability)](https://codeclimate.com/github/Wolox/fictium/maintainability) [![Test Coverage](https://api.codeclimate.com/v1/badges/52afbf838f92fe260b6e/test_coverage)](https://codeclimate.com/github/Wolox/fictium/test_coverage) [![Gem Version](https://badge.fury.io/rb/fictium.svg)](https://badge.fury.io/rb/fictium)

This gem is a documentation helper. The goal of this gem is, by adding small modifications into your existing tests,
you can then transform it into easy REST documentation.

For the initial release, the support is focused explicitly on generating documentation from [RSpec](https://rspec.info/) tests, and generate an [OpenAPI](https://github.com/OAI/OpenAPI-Specification) [V3.0.2](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.2.md) Document.

The current Gem version allows to export into the following formats:

| Exporter    | Class name | Notes |
|---          |---         |---    |
| [OpenApi 3.0](https://github.com/OAI/OpenAPI-Specification/blob/master/versions/3.0.2.md) | `Fictium::OpenApi::V3Exporter`    | The default exporter for the current Gem version. It doesn't include 100% of the OpenAPI specification, but it works for the most common use cases. It's the format [Swagger](https://swagger.io/) uses for documentation. |
| [API Blueprint](https://apiblueprint.org/documentation/specification.html) | `Fictium::ApiBlueprintExporter`| Used by [Apiary](https://apiary.io/). A superset of Markdown with special keywords and controls. |
| [Postman Collection](https://schema.getpostman.com/json/collection/v2.1.0/docs/index.html) | `Fictium::Postman::V2Exporter` | Export your test as a [Postman](https://www.getpostman.com/) collection for easy creation of mock APIs and quick debugging. |

Future versions may provide:

  - OpenApi 1.0 and 2.0
  - Custom HTML exporter

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

Fictium is a Gem to generate documentation from your tests.
Instead of you having to write entirely new tests, the goal of this gem is to provide easy to use,
tags and annotations on your existing tests.

Fictium is closely tied to RSpec and Rails, but it's developed in a way to support more testing suites or engines in future versions.

The primary goal is for generating OpenAPI Documentation, but, just like with RSpec, future versions may provide other output types.

[Check out the wiki too!](https://github.com/Wolox/fictium/wiki)


### Common terminology of this gem

Because this GEM is used to represent REST APIs, this gem, provides some common objects, which are used as a documentation naming scheme. They are independant from the actual documentation format, so each exporter should transform this abstract representation into the actual document representation.

The base object, is de [Fictium::Document](./lib/fictoum/poros/fictium/document). This class represent your whole API.
One is created when the testing starts.

The document, then is divided in resources. The class [Fictium::Resource](./lib/fictoum/poros/fictium/resource) is the one dedicated to handle them. A resource is a Rest object, for example, Posts, Users or Tags.

Each resource is sub divided in actions, [Fictium::Action](./lib/fictoum/poros/fictium/action). Actions are enpoints associated with a REST method.

### Configuration

This gem attemps to complete the documentation for you, so you don't have to constantly document it yourself.
To configure how this gem completes your documentation, you have some configurations available [here](https://github.com/Wolox/fictium/wiki).


### RSpec Integration

Just `require 'fictium/rspec'` in your rails helper and your RSpec test will include everything you need to work in your environment.
(be aware, the current version requires Rails to be previously loaded to work).

At any test of type: :controller, you can just add the following helpers:

```rb
describe PostsController do
  describe action 'GET #index' do
    describe example 'without errors' do
        default_example # You can select an example to be marked as default in your action

        before do
            get :index
        end

        # ... your tests
    end
  end
end
```

The idea, is that your controller has actions, and each actions has examples.
You can, for now, check `spec/controllers` at this repository to

You can deeply customize your endpoints using RSpec.
Check out details [here](./wiki/RSpec-definitions).

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/fictium. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

This gem is developed by [Wolox](https://wolox.com.ar).

Maintainers: [Ramiro Rojo](https://github.com/holywyvern)
Contributors: None (for now...)

![Wolox](https://raw.githubusercontent.com/Wolox/press-kit/master/logos/logo_banner.png)

## Code of Conduct

Everyone interacting in the Fictium project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/Wolox/fictium/blob/master/CODE_OF_CONDUCT.md).
