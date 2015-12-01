module CloudinaryWorkers
  class RemoveTag < Base
    def perform(urls, tag)
      urls.is_a?(String) ? [urls] : urls
      for url in urls
        CloudinaryAdmin.new(url).remove_tag(tag)
      end
    end
  end
end