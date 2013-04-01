require 'spec_helper'

describe Ekto::Machine do
  subject(:machine) { Ekto::Machine.new({}) }

  describe "#start" do
    context "when the machine has started" do
      before do
        machine.start
        machine.sandbox
      end

      it "should accept connections" do
        expect { machine.connect!("ls") }.not_to raise_error
      end

      it "should be connected to a running instance" do
        machine.connect!("cat /proc/meminfo").output.should =~ /MemTotal/
      end
    end
  end

  describe "#stop" do
    context "when the machine has started" do
      before do
        machine.start
        machine.sandbox
      end

      it "should make connections impossible" do
        machine.stop
        expect { machine.connect!("ls") }.to raise_error
      end
    end
  end

  describe "#reset" do
    context "when the machine has started" do
      before do
        machine.start
        machine.sandbox
      end
      it "should wipe changes made to the machine" do
        machine.connect "touch flag_file"
        machine.reset
        machine.connect("ls flag_file").status.should_not be_success
      end
    end
  end

  describe "#initialize" do
    let(:vagrant_config) { VagrantConfig.new }

    before do
      vagrant_config.write
    end

    subject(:machine) { Ekto::Machine.new(working_path: vagrant_config.working_path) }

    it "should accept a working path" do
      File.exist?(vagrant_config.working_path.join('Vagrantfile')).should be_true
      machine.start
      machine.connect('sudo ifconfig').output.should =~ /#{vagrant_config.ip}/
    end
  end
end
