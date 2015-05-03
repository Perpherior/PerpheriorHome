class Book < ActiveRecord::Base
  belongs_to :admin
  has_many :chapters

  PAPERCLIP_OPTIONS = {
    styles: { thumb:  "100x100#", cover_page: "210X170#" },
    path:    ":rails_root/public/system/:attachment/:id-:hash/:style/:filename",
    url:     "/system/:attachment/:id-:hash/:style/:filename",
    storage: (:filesystem),
    hash_secret:  "ThisIsThePiSecretStringForPractices"
  }

  has_attached_file :cover, PAPERCLIP_OPTIONS
  validates_attachment_content_type :cover,
                                    content_type:
    [
      "image/jpeg",
      "image/png",
      "image/jpg"
    ]

	def cover_img_url
		cover.url(:cover_page) || "./cs.jpeg"
	end

  def prepare_content(url)
		content = File.read(url)
		detection = CharlockHolmes::EncodingDetector.detect(content)

		CharlockHolmes::Converter.convert content, detection[:encoding], 'UTF-8'
  end
end
