require 'spec_helper'
require 'fileutils'
require 'tmpdir'

describe UsernamePassword do
  let(:input) { StringIO.new }
  let(:output) { StringIO.new }
  let(:auth_file) { File.join(Dir.tmpdir, "uptestfile") }
  subject { UsernamePassword }
  
  before do
    UsernamePassword.input = input
    UsernamePassword.output = output
  end
  
  after do
    UsernamePassword.auth_file = nil
    FileUtils.rm_f(auth_file) if File.exists?(auth_file)
  end
  
  it "asks for a username and password" do
    input << "joe224\n"
    input << "secret\n"
    input.rewind
    
    result = UsernamePassword.get
    result[:username].should == "joe224"
    result[:password].should == "secret"
    
    output.string.should == "Username: Password: \n"
  end
  
  it "can save the entered username and password to a file that is used in later calls" do
    UsernamePassword.auth_file = auth_file
    
    input << "joe224\n"
    input << "secret\n"
    input.rewind
    UsernamePassword.get

    # Prevent writing to output
    output.close

    3.times do
      UsernamePassword.get.should == {:username => 'joe224', :password => 'secret'}
    end
  end
  
  it 'does not save the username password in plaintext' do
    UsernamePassword.auth_file = auth_file
    input << "joe224\n"
    input << "secret\n"
    input.rewind
    UsernamePassword.get
    
    file_contents = File.read(auth_file)
    file_contents.should_not =~ /joe224/
    file_contents.should_not =~ /secret/
  end
end