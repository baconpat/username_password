require 'highline'
require 'ezcrypto'
require 'yaml'

module UsernamePassword
  @@input_io = $stdin
  @@output_io = $stderr
  @@auth_file = nil
  
  # Set the IO object to use for input
  def self.input=(io)
    @@input_io = io
  end

  # Set the IO object to use for output
  def self.output=(io)
    @@output_io = io
  end
  
  # Set the location of a file to save the username/password (encrypted) so the user
  # won't have to type it in every time
  def self.auth_file=(path)
    @@auth_file = path
  end
  
  # Asks the user for a username/password. If an auth_file has been specified
  # the results will be saved to that file and the user will not have to 
  # type the information in again.
  def self.get
    return read_file if @@auth_file && File.exists?(@@auth_file)
    
    highline = HighLine.new(@@input_io, @@output_io)
    username = highline.ask("Username: ")
    password = highline.ask("Password: ") { |q| q.echo = false }
    
    result = {:username => username.to_s, :password => password.to_s}
    save_file(result) if @@auth_file
    result
  end
  
  private
  def self.save_file(hash) #:nodoc:#
    File.open(@@auth_file, 'w') { |file| file.write encryption.encrypt64(YAML.dump(hash)) }
  end
  
  def self.read_file #:nodoc:#
    YAML.load(encryption.decrypt64(File.read(@@auth_file)))
  end
  
  def self.encryption #:nodoc:#
    EzCrypto::Key.with_password(%|(FrDx&M(44;{TxU]RtYk69Khma6Li2KFCU:V6jj*YizpM4GiRd|, "salty")
  end
end
