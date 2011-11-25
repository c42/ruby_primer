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

  private
  def lessons(chapter_directory_name)
    Pathname.glob("#{@base_path}/#{chapter_directory_name}/*").map do |lesson_filename|
       parse_lesson(lesson_filename)
    end
  end


  def parse_lesson(lesson_filename)
    content = File.read(lesson_filename.to_s).split("\n")

    title = content.shift.gsub('title - ', '') if content.first.include? 'title -'
    title ||= lesson_filename.to_s.titlecase

    {
      "short_name" => lesson_filename.basename.sub_ext("").to_s,
      "raw_content" => content.join("\n"),
      "title" => title
    }
  end
end
