module BookUpload
  class Base
    attr_reader :file_url, :book, :file

    def initialize(id, url)
      @file_url = url
      @file = resource
      @book = Book.find(id)
    end

    def call
      produce_book_chapters
    end

    private

    def resource
      puts "No resource found!"
    end

    def produce_book_chapters
      puts "Can't produce chapters"
    end

    def write_content(name, content)
      return if content.nil?
      book.chapters.create!(name: name, content: content)
    end
  end
end