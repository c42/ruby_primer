require 'spec_helper'
require 'uuid'

describe RubymonkClient do
  describe "POST hash to rubymonk server" do
    before(:each) do
      @fixtures_root = File.join(File.dirname(__FILE__), '..', 'fixtures', "docs")
      @model = RubymonkModel.new(@fixtures_root)
      @chapters = @model.build_hash
      @sandbox_token = UUID.new.generate
      @sandbox_url = "http://rubymonk-open-0.heroku.com/sandbox/import/create"
      @client = RubymonkClient.new(@sandbox_url, @sandbox_token)
    end

    it "makes a POST request" do
      @client.sync_data(@chapters).should be_ok
    end
  end
end
