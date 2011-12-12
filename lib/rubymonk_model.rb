require 'pathname'

class RubymonkModel
  def initialize(path)
    @base_path = path
    @chapter_directories = Pathname.glob(@base_path + "/*").map(&:basename)
  end

  def build_hash
    {
      "chapters" =>
      @chapter_directories.sort.map do |chapter_directory_name|
        {
          "short_name" => chapter_directory_name.to_s,
          "lessons" => lessons(chapter_directory_name)
        }
      end
    }
  end

  private
  def lessons(chapter_directory_name)
    sort_lessons(chapter_directory_name).map do |lesson_filename|
      parse_lesson(lesson_filename)
    end
  end

  def sort_lessons(chapter_directory_name)
    Pathname.glob("#{@base_path}/#{chapter_directory_name}/*").sort_by do |filename|
      filename.basename.to_s =~ /^(\d+).-/
      [$1.to_i]
    end
  end

  def parse_lesson(lesson_filename)
    content = File.read(lesson_filename.to_s, :encoding => "utf-8").split("\n")

    title = (content.shift.gsub('title - ', '') if content.first.include? 'title -') unless content.empty?
    title ||= lesson_filename.basename.to_s.titlecase

    {
      "short_name" => lesson_filename.basename.sub_ext("").to_s,
      "raw_content" => content.join("\n"),
      "title" => title
    }
  end
end
