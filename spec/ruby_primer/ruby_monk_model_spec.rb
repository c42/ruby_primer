require 'spec_helper'

describe RubyMonkModel do

  describe "create a hash from the given directory" do

    before(:each) do
      @fixtures_root = File.join(File.dirname(__FILE__), '..', 'fixtures', "docs")
      @model = RubyMonkModel.new(@fixtures_root)
      @chapters = @model.build_hash
    end

    it "reads the chapters" do
      @chapters.first["short_name"].should eq "sample_chapter"
    end

    it "reads the lessons of the chapters" do
      lessons = @chapters.first["lessons"]
      lessons.first["short_name"].should eq "sample_lesson"
    end

    it "reads the content of the lesson haml" do
      lessons = @chapters.first["lessons"]
      lessons.first["raw_content"].should eq File.read("#{@fixtures_root}/sample_chapter/sample_lesson.haml")
    end
  end
end