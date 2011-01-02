require 'highline'
require 'ezcrypto'

module UsernamePassword
  @@input_io = $stdin
  @@output_io = $stderr
  @@auth_file = nil
  
  def self.input=(io)
    @@input_io = io
  end

  def self.output=(io)
    @@output_io = io
  end
  
  def self.auth_file=(path)
    @@auth_file = path
  end
  
  def self.get
    return read_file if @@auth_file && File.exists?(@@auth_file)
    
    highline = HighLine.new(@@input_io, @@output_io)
    username = highline.ask("Username: ")
    password = highline.ask("Password: ") { |q| q.echo = false }

    save_file(username, password) if @@auth_file
    {:username => username, :password => password}
  end
  
  private
  def self.save_file(username, password)
    hash = {'x' => username, 'y' => password}
    File.open(@@auth_file, 'w') { |file| file.write encryption.encrypt64(YAML.dump(hash)) }
  end
  
  def self.read_file
    hash = YAML.load(encryption.decrypt64(File.read(@@auth_file)))
    {:username => hash['x'], :password => hash['y']}
  end
  
  def self.encryption
    EzCrypto::Key.with_password(%|(FrDx&M(44;{TxU]RtYk69Khma6Li2KFCU:V6jj*YizpM4GiRd|, "salty")
  end
end
