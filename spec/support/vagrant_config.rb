class VagrantConfig
  attr_accessor :username, :ip
  def initialize
    @username="deploy"
    @ip="192.168.33.11"
  end

  def write
    FileUtils.mkdir_p working_path
    File.write( working_path.join("Vagrantfile"), output )
  end

  def output
    templater = ERB.new(File.read(PROJECT_PATH.join("templates/Vagrantfile.erb")))
    templater.result(binding)
  end

  def working_path
    @working_path ||= PROJECT_PATH.join("tmp/vagrants/#{vm_name}")
  end

  def vm_name
    @vm_name ||= SecureRandom.hex(4)
  end

end
