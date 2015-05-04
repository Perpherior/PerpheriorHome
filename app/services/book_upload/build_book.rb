module BookUpload
  class BuildBook < Base
    def call
      produce_book_chapters
    end

    private

    def is_chapter_sign(line)
      /第.+章\s/.match(line)
    end

    def strip_line(line)
      line.strip
    end

    def file_size
      file.lines.size
    end

    def produce_book_chapters
      content = ""
      title = "init"
      file.lines.each_with_index do |line, index|  
        stripped_line = strip_line(line)
        if is_chapter_sign(line) || index == file_size - 1
          write_content(title, content)
          content = ""
          title = stripped_line
        else
          content += line
        end
      end
    end

    def write_content(name, content)
      return if content.nil?
      book.chapters.create!(name: name, content: content)
    end
  end
end