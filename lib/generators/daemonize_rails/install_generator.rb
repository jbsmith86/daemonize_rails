require 'rails/generators'
require 'rails/generators/base'

module DaemonizeRails
  class Generators
    class InstallGenerator < Rails::Generators::Base
      def install
        app_path = Dir.pwd
        if app_path[/^\/var\/www\/[a-zA-Z0-9\-_.]+/] != app_path
          raise "Folder check invalid. Please put you Rails project in \"/var/www\""
        end
        app_name = Dir.pwd[/[A-Za-z0-9_.-]*?(\/|)$/].gsub("/","")

        unicorn_binding = DaemonizeRails::UnicornConfig.new(app_name, 4).get_binding
        init_binding = DaemonizeRails::InitConfig.new(app_name, `echo $PATH`.chomp).get_binding

        unicorn = DaemonizeRails::Unicorn.new(unicorn_binding, app_name)
        init = DaemonizeRails::Init.new(init_binding, app_name)

        create_file "config/unicorn.rb" do
          "#{unicorn.make_config_file}"
        end
        puts `chmod 755 ./config/unicorn.rb`

        init_path = "/etc/init.d/#{@app_name}"
        create_file init_path do
            "#{init.make_config_file}"
        end
        puts `chmod 755 /etc/init.d/#{app_name}`
        puts `chmod +x /etc/init.d/#{app_name}`
        puts `update-rc.d #{app_name} defaults`
      end
    end
  end
end
