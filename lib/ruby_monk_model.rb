require 'pathname'

class RubyMonkModel
  def initialize(path)
    @base_path = path
    @chapter_directories = Pathname.glob(@base_path + "/*").map(&:basename)
  end

  def build_hash
    {
      "chapters" =>
      @chapter_directories.map do |chapter_directory_name|
        { 
          "short_name" => chapter_directory_name.to_s,
          "lessons" => lessons(chapter_directory_name)
        }
      end
    }
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
