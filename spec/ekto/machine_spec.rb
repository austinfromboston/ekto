require 'spec_helper'

describe Ekto::Machine do
  subject(:machine) { Ekto::Machine.new(TEST_OPTIONS) }
  before do
    machine.start
    machine.sandbox
  end

  describe "#start" do

    it "should accept connections" do
      expect { machine.connect!("ls") }.not_to raise_error
    end

    it "should be connected to a running instance" do
      machine.connect!("cat /proc/meminfo").output.should =~ /MemTotal/
    end
  end

  describe "#stop" do
    it "should make connections impossible" do
      machine.stop
      expect { machine.connect!("ls") }.to raise_error
    end
  end

  describe "#reset" do
    it "should wipe changes made to the machine" do
      machine.connect "touch flag_file"
      machine.reset
      machine.connect("ls flag_file").status.should_not be_success
    end
  end
end
