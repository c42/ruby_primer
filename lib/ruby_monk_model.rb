require 'pathname'
require 'json'

class RubyMonkModel
  def initialize(path, auth_token)
    @base_path = path
    @auth_token = auth_token
    @chapter_directories = Pathname.glob(@base_path + "/*").map(&:basename)
  end

  def build_hash
    @chapter_directories.map do |chapter_directory_name|
      {
          "short_name" => chapter_directory_name.to_s,
          "sandbox_token" => @auth_token,
          "lessons" => lessons(chapter_directory_name)
      }
    end
  end

  def lessons(chapter_directory_name)
    Pathname.glob("#{@base_path}/#{chapter_directory_name}/*").map do |lesson_filename|
      {
          "short_name" => lesson_filename.basename.sub_ext("").to_s,
          "title" => title(lesson_filename), 
          "raw_content" => raw_content(lesson_filename)
      }
    end
  end

  def title(lesson_filename)
    File.open(lesson_filename, &:readline).split(" - ")[1]
  end

  def raw_content(lesson_filename)
    File.new(lesson_filename.to_s).read
  end
end
