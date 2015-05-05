module BookUpload
  class BuildFromTXT < Base
    private

    def resource
      content = File.open(file_url).read
      detection = CharlockHolmes::EncodingDetector.detect(content)

      CharlockHolmes::Converter.convert content, detection[:encoding], 'UTF-8' 
    end

    def produce_book_chapters
      content = ""
      title = "init"
      file.lines.each_with_index do |line, index|
        if end_of_chapter?(line, index)
          write_content(title, content)
          content = ""
          title = strip_line(line)
        else
          content += line
        end
      end      
    end

    def end_of_chapter?(line, idx)
      chapter_title?(line) || idx == file_size - 1
    end

    def chapter_title?(line)
      /第.+[章|回]\s/.match(line)
    end

    def strip_line(line)
      line.strip
    end

    def file_size
      file.lines.size
    end
  end
end