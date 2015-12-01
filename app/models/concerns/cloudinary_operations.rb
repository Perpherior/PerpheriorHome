module CloudinaryOperations
  extend ActiveSupport::Concern
  included do
    around_destroy :remove_from_cloudinary
    after_update :remove_outdated_from_cloudinary
    after_save :remove_delete_tag, unless: Proc.new { preview_urls.empty? }
  end

  def remove_delete_tag
    CloudinaryWorkers::RemoveTag.perform_async(latest_urls, 'delete')
  end

  def remove_from_cloudinary
    remove_urls = latest_urls
    yield
    CloudinaryWorkers::Remove.perform_async(remove_urls) unless remove_urls.empty?
  end

  def remove_outdated_from_cloudinary
    CloudinaryWorkers::Remove.perform_async(preview_urls) unless preview_urls.empty?
  end

  private
  def latest_urls
    iterate_attributes(attributes)
  end

  def preview_urls
    iterate_attributes(changed_attributes)
  end

  def iterate_attributes(attrs)
    urls = []
    attrs.each do |name, value|
      urls.push exclude_derived_path(value) if value.is_a?(String) && cloudinary?(value)
    end
    urls.uniq
  end

  def exclude_derived_path(url)
    url.gsub(/c\_.*h\_\d*\//, '')
  end

  def cloudinary?(url)
    url.index("https://res.cloudinary.com/") == 0
  end
end