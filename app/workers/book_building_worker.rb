class BookBuildingWorker
  include Sidekiq::Worker
  sidekiq_options retry: :false

  def perform(file_url, id)
    BookUpload::BuildBook.new(file_url, book(id)).call
  end

  private

  def book(id)
  	Book.find(id)
  end
end
