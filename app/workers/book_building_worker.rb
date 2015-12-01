class BookBuildingWorker
  include Sidekiq::Worker
  sidekiq_options retry: :false

  def perform(id, source_url)
    "BookUpload::BuildFrom#{resource(source_url)}".constantize.new(id, source_url).call
  end

  private

  def resource(source_url)
    File.extname(source_url).gsub(".", "").upcase
  end

  def book(id)
    Book.find(id)
  end
end
