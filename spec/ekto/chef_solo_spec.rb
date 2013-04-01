require 'spec_helper'

describe Ekto::ChefSolo do
  describe "#install" do
    with_unique_instance do
      subject { Ekto::ChefSolo.new(machine).install }
      it "should run" do
        subject
        machine.connect("which chef-solo").status.should be_success
      end
    end
  end
end
