# Daemonize Rails

Daemonize Rails will configure your server to add a new daemon process for your rails app in production.

## Installation

**Intended for use with Debian/Ubuntu, Unicorn and Nginx**

Add Daemonize Rails and Unicorn to your Rails app's Gemfile:

    gem 'daemonize_rails'
    gem 'unicorn'

Then run bundle:

    $ bundle

## Usage

Place your Rails project in "/var/www/projectname"

Run the generator:

    rails generate daemonize_rails:install

This will create your unicorn.rb and init.d file

Finally, start your app

    $ /etc/init.d/myapp start
    [myapp][22645]: Trying to start server...
    [myapp][22668]: server started

You can also

    $ /etc/init.d/myapp stop
    $ /etc/init.d/myapp restart
    
Enjoy!

## Contributing

1. Fork it ( http://github.com/jbsmith86/daemonize_rails/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
