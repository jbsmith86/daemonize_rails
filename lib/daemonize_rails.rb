require "daemonize_rails/version"
require "erb"

module DaemonizeRails
  class Unicorn
    def initialize(bindings, app_name)
      @bindings = bindings
      @app_name = app_name
      @app_path = Dir.pwd
    end

    def make_config_file
      check_and_create_folder(@app_path + "/tmp")
      check_and_create_folder(@app_path + "/tmp/pids")
      unicorn_file = ERB.new File.new(File.dirname(__FILE__) + "/unicorn_template.erb").read, nil, "%"
      unicorn_file.result(@bindings)
    end

    def check_and_create_folder(path)
      if !File.exists? path
        Dir.mkdir path
        puts `chmod 755 #{path}`
      end
    end
  end

  class Init
    def initialize(bindings, app_name)
      @bindings = bindings
      @app_name = app_name
    end

    def make_config_file
      init_file = ERB.new File.new(File.dirname(__FILE__) + "/init_template.erb").read, nil, "%"
      init_output = open("/etc/init.d/#{@app_name}", 'w') { |f| f.puts init_file.result(@bindings) }
      init_output.close
    end
  end

  class UnicornConfig
    def initialize(app_name, workers)
      @app_name = app_name
      @workers = workers
    end

    def get_binding
      return binding()
    end
  end

  class InitConfig
    def initialize(app_name, path)
      @app_name = app_name
      @path = path
    end

    def get_binding
      return binding()
    end
  end
end
