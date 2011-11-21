require 'pathname'
require 'json'

class RubyMonkModel
  def initialize(path)
    @base_path = path
    @chapter_directories = Pathname.glob(@base_path + "/*").map(&:basename)
  end

  def build_hash
    @chapter_directories.map do |chapter_directory_name|
      {
          "short_name" => chapter_directory_name.to_s,
          "lessons" => lessons(chapter_directory_name)
      }
    end
  end

  def lessons(chapter_directory_name)
    Pathname.glob("#{@base_path}/#{chapter_directory_name}/*.haml").map do |lesson_filename|
      {
          "short_name" => lesson_filename.basename.sub_ext("").to_s,
          "raw_content" => raw_content(lesson_filename)

      }
    end
  end
  def raw_content(lesson_filename)
    File.new(lesson_filename.to_s).read
  end
end