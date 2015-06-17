class BookBuildingWorker
  include Sidekiq::Worker
  sidekiq_options retry: :false

  def perform(filepath, id)
    "BookUpload::BuildFrom#{resource(filepath)}".constantize.new(path(filepath), book(id)).call
    book(id).finish_build!
  end

  private

  def resource(filepath)
    File.extname(path(filepath)).gsub(".", "").upcase
  end

  def path(filepath)
    /(.+)\?/.match(filepath)[1]
  end

  def book(id)
  	Book.find(id)
  end
end
