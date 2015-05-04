module BookUpload
  class Base
    attr_reader :file, :book

    def initialize(file, book)
      @file = prepare_content(file)
      @book = book
    end

    private

    def prepare_content(file_url)
      content = File.open(file_url)
      detection = CharlockHolmes::EncodingDetector.detect(content)

      CharlockHolmes::Converter.convert content, detection[:encoding], 'UTF-8'
    end
  end
end