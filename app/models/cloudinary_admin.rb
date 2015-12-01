class CloudinaryAdmin
  attr_accessor :url, :public_id

  def initialize(arg = '')
    @url = arg || ''
    @public_id = grab_id
  end

  def onthefly(crop = 'thumb', height = 100, width = 100)
    return unless valid?
    url.gsub(version, "#{image_params(crop, height, width)}#{version}")
  end

  def remove
    Cloudinary::Api.delete_resources(public_id, resource_type: resource_type, type: type)
  end

  def remove_tag(tag)
    Cloudinary::Uploader.remove_tag(tag, ['sample_id', public_id], resource_type: resource_type, type: type )
  end

  def remove_by_tag(tag)
    Cloudinary::Api.delete_resources_by_tag(tag)
  end

  def resource
    Cloudinary::Api.resource(public_id, resource_type: resource_type, type: type)
  end

  def version
    url[/\/v\d\d*/] || '/s3'
  end

  def image_params(crop, width, height)
    "/c_#{crop},w_#{width},h_#{height}"
  end

  private
  def valid?
    url.present? && base_url.present?
  end

  def base_url
    url[/^http.*\/v\d*\//] || url[/^http.*\/s3\//] || ""
  end

  def resource_type
    ['image', 'video', 'raw'].each do |type|
      return type if send("#{type}_types").include? File.extname(url)
    end
  end

  def type
    'upload'
    # resource_type == 'raw' ? 'private' : 'upload'
  end

  def image_types
    ['.jpg','.jpeg', '.gif', '.png']
  end

  def video_types
    ['.mp3', '.wav', '.aiff']
  end

  def raw_types
    ['.txt', '.pdf']
  end

  def grab_id
    return unless base_url.present?
    temp = url.gsub(base_url, "")
    resource_type == 'raw' ? temp : temp.gsub(File.extname(temp), '')
  end
end