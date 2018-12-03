# Auth0Password
[![Build Status](https://travis-ci.org/mnc/auth0_password.svg?branch=master)](https://travis-ci.org/mnc/auth0_password)
[![MIT License](http://img.shields.io/badge/license-MIT-blue.svg?style=flat)](LICENSE)

Auth0Password is a Ruby gem to generate random password for Auth0 database connection.
The password can be generated appropriately to each of Auth0 password strength (excellent, good, fair and low). 

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
Auth0Password.new.excellent

# good
Auth0Password.new.good

# fair and min length of password is 10
Auth0Password.new(min_length: 10).fair

# low
Auth0Password.new.low
```

### Password length
```ruby
# set password length to generate as 15
Auth0Password.new.excellent(15)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.


To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mnc/auth0_password. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Auth0Password project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/auth0_password/blob/master/CODE_OF_CONDUCT.md).
