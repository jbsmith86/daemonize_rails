[![Gem Version](https://badge.fury.io/rb/daemonize_rails.svg)](http://badge.fury.io/rb/daemonize_rails)
# Daemonize Rails

Daemonize Rails will configure your server to add a new daemon process for your rails app in production.

## Installation

**Intended for use with Debian/Ubuntu, Unicorn and Nginx**

Add Daemonize Rails and Unicorn to your Rails app's Gemfile:

    gem 'daemonize_rails'
    gem 'unicorn'

Then run bundle:

    $ bundle
    
Install Nginx

    $ sudo apt-get install nginx

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
    
###Configure Nginx

Add the following to /etc/nginx/sites-enabled/nginx.conf


```
upstream <myapp> {
  server unix:/tmp/unicorn.<myapp>.sock fail_timeout=0;
}

server {
    server_name  <mydomain>.com;
    rewrite ^(.*) http://www.<mydomain>.com$1 permanent;
}

server {
  listen 80;
  server_name www.<mydomain>.com;
  root /var/www/<myapp>/public;

  location ^~ /assets/ {
    gzip_static on;
    expires max;
    add_header Cache-Control public;
  }

  try_files $uri/index.html $uri @<myapp>;
  location @<myapp> {
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header Host $http_host;
    proxy_redirect off;
    proxy_pass http://<myapp>;
  }

  error_page 500 502 503 504 /500.html;
  client_max_body_size 20M;
  keepalive_timeout 10;
}

```
    
Enjoy!

## Contributing

1. Fork it ( http://github.com/jbsmith86/daemonize_rails/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
