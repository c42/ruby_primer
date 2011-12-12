require 'spec_helper'
describe RubymonkToken do
  it "creates a new token" do
    rubymonk_token = RubymonkToken.new('.spec_token')
    token = rubymonk_token.get_token
    token.should_not be_empty
    rubymonk_token.destroy
  end
  it "gives the same token after it has been initialized once" do
    rubymonk_token = RubymonkToken.new('.spec_token')
    new_token = rubymonk_token.get_token
    RubymonkToken.new('.spec_token').get_token.should == new_token
    rubymonk_token.destroy
  end
  it "destroys an existing token" do
    rubymonk_token = RubymonkToken.new('.spec_token')
    rubymonk_token.get_token
    rubymonk_token.destroy
    File.should_not exist('.spec_token')
  end
end
