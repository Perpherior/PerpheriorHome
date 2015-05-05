module BookUpload
  class BuildFromPDF < Base
    private

    def resource
      PDF::Reader.new(file_url)
    end

    def produce_book_chapters
      file.pages.each_with_index do |page, index|
        title = "Page #{index+1}"
        content = page.text
        write_content(title, content)
      end
    end
  end
end