require "rubygems"
require "bundler/setup"
require 'rspec'
require 'username_password'

Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require f}

RSpec.configure do |config|
  # config.before do
  # end
  # 
  # config.after do
  # end
end
