class BookBuildingWorker
  include Sidekiq::Worker
  sidekiq_options retry: :false

  def perform(filepath, id)
    "BookUpload::BuildFrom#{resource(filepath)}".constantize.new(filepath, book(id)).call
    book(id).finish_upload!(filepath)
  end

  private

  def resource(filepath)
    File.extname(filepath).gsub(".", "").upcase
  end

  def book(id)
  	Book.find(id)
  end
end
