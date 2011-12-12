require 'spec_helper'

describe RubymonkModel do

  describe "create a hash from the given directory" do

    before(:each) do
      @fixtures_root = File.join(File.dirname(__FILE__), '..', 'fixtures', "docs")
      @model = RubymonkModel.new(@fixtures_root)
      @content = @model.build_hash
      @chapters = @content["chapters"]

    end

    it "reads the chapters" do
      @chapters.first["short_name"].should eq "01-sample_chapter"
    end

    it "reads the lessons of the chapters" do
      lessons = @chapters.first["lessons"]
      lessons.first["short_name"].should eq "sample_lesson"
    end

    it "discards the title from the raw content" do
      lessons = @chapters.first["lessons"]
      lessons.first["raw_content"].should_not include "title - "
    end

    it "reads the content of the lesson haml" do
      sample_content = <<-DATA
.section :sample_lesson, "This is a sample lesson", 41
  %p
    Sample lesson
DATA
.chop
      lessons = @chapters.first["lessons"]
      lessons.first["raw_content"].should eq(sample_content)
    end
  end
end
