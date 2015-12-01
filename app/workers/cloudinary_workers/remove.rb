module CloudinaryWorkers
  class Remove < Base
    def perform(urls)
      urls.is_a?(String) ? [urls] : urls
      for url in urls
        CloudinaryAdmin.new(url).remove
      end
    end
  end
end