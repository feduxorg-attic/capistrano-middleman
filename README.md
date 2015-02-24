# Capistrano::Middleman

Deploy middleman app with the help of capistrano 3.
[`capistrano-scm-copy`](https://github.com/wercker/capistrano-scm-copy) was
quite helpful as template for this gem.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'capistrano-middleman'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capistrano-middleman

## Usage

You just need to change `:scm` to `:middleman`.

```
set :scm, :middleman
```

And make sure you've got the following software installed:

Machine running Capistrano:

* Capistrano 3
* tar

Servers:

* mktemp
* tar

## Contributing

1. Fork it ( https://github.com/[my-github-username]/capistrano-middleman/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
