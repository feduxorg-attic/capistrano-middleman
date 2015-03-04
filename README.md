# capistrano-middleman

[![Gem Version](https://badge.fury.io/rb/capistrano-middleman.svg)](http://badge.fury.io/rb/capistrano-middleman)

Deploy middleman app with the help of [`capistrano`](https://github.com/capistrano/capistrano) (Vers. 3).
[`capistrano-scm-copy`](https://github.com/wercker/capistrano-scm-copy) was
quite helpful as template for this gem.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'capistrano-middleman', require: false
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

Machine running [`capistrano`](https://github.com/capistrano/capistrano):

* [capistrano 3](https://github.com/capistrano/capistrano)
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
