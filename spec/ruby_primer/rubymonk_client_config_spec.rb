require 'spec_helper'

describe RubymonkClientConfig do
  it "creates a new token" do
    config = RubymonkClientConfig.new('.spec_config')
    token = config.get["sandbox_token"]
    token.should_not be_empty
    config.destroy
  end

  it "gives the same token after it has been initialized once" do
    config = RubymonkClientConfig.new('.spec_config')
    new_token = config.get["sandbox_token"]
    RubymonkClientConfig.new('.spec_config').get["sandbox_token"].should == new_token
    config.destroy
  end
  
  it "picks a new sandbox server" do
    config = RubymonkClientConfig.new('.spec_config')
    server = config.get["sandbox_server"]
    server.should_not be_empty
    config.destroy    
  end

  it "gives the same sandbox server after it has been initialized once" do
    config = RubymonkClientConfig.new('.spec_config')
    new_server = config.get["sandbox_server"]
    RubymonkClientConfig.new('.spec_config').get["sandbox_server"].should == new_server
    config.destroy
  end

  it "destroys an existing token" do
    config = RubymonkClientConfig.new('.spec_config')
    config.get
    config.destroy
    File.should_not exist('.spec_config')
  end
end
