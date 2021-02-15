# Back Office Theme

This is Merchant's Edition's default and only back office theme. It comes with a couple of styles.


## Building

Only styles need building. If tools were installed as described in [Prerequisites](#Prerequisites), it goes like this:
```
  cd admin-dev/themes/default
  "${HOME}"/.gem/ruby/*/bin/compass compile
```
Compilation takes a while, like 2 minutes. Compass' memory footprint is fairly low, less than 300 MiB.

Compiled CSS should get committed into the code repository. Not compiled source
maps, though, as these are only useful during development.


## Prerequisites

Compiling the theme requires Compass, a tool written in Ruby.

### Installation on Debian/Ubuntu:

This is a conservative approach, keeping system wide installations at a minimum.
```
  sudo apt-get install ruby-full
  gem install --user-install compass
```

### Cleanup on Debian/Ubuntu:

Tidy people may want to cleanup after being done. This assumes no other Ruby Gems are installed:
```
  sudo apt-get purge ruby-full
  sudo apt-get --purge autoremove
  rm -r "${HOME}"/.gem
  rm -r admin-dev/themes/default/.sass-cache
```
