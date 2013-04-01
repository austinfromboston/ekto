module UniqueInstance
  module EachMethods
    def machine
      self.class.machine
    end

    def vagrant_config
      self.class.vagrant_config
    end

    def clear_machine
      self.class.clear_machine
    end
  end

  def vagrant_config
    @vagrant_config ||= VagrantConfig.new
  end

  def machine
    @machine ||= Ekto::Machine.new(working_path: vagrant_config.working_path)
  end

  def clear_machine
    @machine = nil
    @vagrant_config = nil
  end

  def with_unique_instance
    before :all do
      vagrant_config.write
      machine.start
      machine.sandbox
    end

    after :each do
      machine.reset
    end

    after :all do
      machine.stop
      clear_machine
    end

    yield

  end
end
