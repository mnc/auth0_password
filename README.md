# Auth0Password

This is an Auth0 password generator gem.
You can generate a password for Auth0 database connection, which is suitable with each password strength.
This gem supports following password strength, excellent, good, fair and low.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'auth0_password'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install auth0_password

## Usage

### Basic
```ruby
# excellent
Auth0Password.new(strength: :excellent).generate

# good
Auth0Password.new(strength: :good).generate

# fair and min length of password is 10
Auth0Password.new(strength: :fair, min_length: 10).generate

# low
Auth0Password.new(strength: :low).generate
```

### Password length
```ruby
# set password length to generate as 15
Auth0Password.new(strength: :excellent).generate(15)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/auth0_password. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Auth0Password project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/auth0_password/blob/master/CODE_OF_CONDUCT.md).
