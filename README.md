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


### Activate plugin

You just need to change `:scm` to `:middleman` in your `deploy.rb`.

```
set :scm, :middleman
```

### Configuration

You can configure `middleman-presentation` by using the following options:

```ruby
# Local name of archive build from middleman-build-directory
set :archive_name, 'archive.zip'

# Name of build_directory
set :build_dir, 'build'

# Name of source directory
set :source_dir, 'source'

# Keep permissions from filesystem
set :keep_filesystem_permissions, false

# Overwrite permissions of directories
set :directory_permissions, 2775

# Overwrite permissions of files
set :file_permissions, 0664
```

### Required Software

Machine running [`capistrano`](https://github.com/capistrano/capistrano): [capistrano 3](https://github.com/capistrano/capistrano)

Servers:

* mktemp
* unzip

## Contributing

1. Fork it ( https://github.com/[my-github-username]/capistrano-middleman/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
