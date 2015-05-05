class BookBuildingWorker
  include Sidekiq::Worker
  sidekiq_options retry: :false

  def perform(file_url, id)
    "BookUpload::BuildFrom#{resource(file_url)}".constantize.new(file_url, book(id)).call
  end

  private

  def resource(file_url)
    File.extname(file_url).gsub(".", "").upcase
  end

  def book(id)
  	Book.find(id)
  end
end
