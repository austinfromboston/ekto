module Ekto
  class Machine
    class CommandExecutionFailed < StandardError; end
    Response = Struct.new(:output, :status)

    def initialize(opts)
      @opts = opts
    end

    def connect(command)
      exec "vagrant ssh -c '#{command}'"
    end

    def connect!(command)
      connect(command).tap do |response|
        raise CommandExecutionFailed.new(cmd) unless response.status.success?
      end
    end

    def start
      exec "vagrant up"
    end

    def stop
      exec "vagrant halt"
    end

    def destroy
      exec "vagrant destroy -f"
    end

    def sandbox(start=true)
      exec "vagrant sandbox #{start ? "on" : "off"}"
    end

    def reset
      exec "vagrant sandbox rollback"
    end

    protected 

    def exec(cmd)
      log "running #{cmd} in path #{working_path}"
      response = Response.new *Open3.capture2e(cmd, :chdir=> working_path)
      log response.output
      log "exited with code #{response.status.exitstatus}\n"
      response
    end

    def working_path
      @opts[:working_path] || PROJECT_ROOT.join('spec/fixtures/default')
    end

    def log(msg)
      puts msg
    end
  end
end
