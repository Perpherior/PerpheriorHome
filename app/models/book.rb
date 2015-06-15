class Book < ActiveRecord::Base
  include AASM

  belongs_to :admin
  has_many :chapters, dependent: :destroy
  has_one :bookmark, dependent: :destroy

  PAPERCLIP_OPTIONS = {
    styles: { thumb:  "100x100#", cover_page: "210X170#" },
    path:    ":rails_root/public/system/:filename",
    url:     "/system/:filename",
    storage: (:filesystem),
    hash_secret:  "ThisIsThePiSecretStringForPractices"
  }

  delegate :chapter_id, to: :bookmark, prefix: true, allow_nil: true

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

  def has_bookmark
    bookmark.present?
  end

  def chapters_size
    chapters.size
  end

  aasm column: "state" do
    state :init, initial: true
    state :uploading
    state :done

    event :upload do
      transitions from: [:init, :done], to: :uploading, after: :create_temp_file
    end

    event :finish_upload do
      transitions from: :uploading, to: :done, after: :remove_temp_file
    end
  end

  def create_temp_file(params)
    if File.exist?(params[:file].path)
      FileUtils.mv params[:file].path, temp_filepath(params[:file].path)
      build_chapters(temp_filepath(params[:file].path), params[:id])
    end
  end

  def remove_temp_file(filepath)
    File.delete(filepath) if File.exist?(filepath)
  end

  def temp_filepath(filepath)
    "public/temp/#{File.basename(filepath)}"
  end

  def build_chapters(filepath, id)
    BookBuildingWorker.perform_async(filepath, id)
  end
end
