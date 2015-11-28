class Book < ActiveRecord::Base
  include AASM

  belongs_to :admin
  has_many :chapters, dependent: :destroy
  has_one :bookmark, dependent: :destroy

  after_update :publish!, if: :uploading?
  before_update :randomize_file_name, if: :set_randomize_name_condition

  COVER_OPTIONS = {
    styles: { thumb:  "100x100#", cover_page: "210X170#" },
    path:    ":rails_root/public/system/:id-:hash:filename",
    url:     "/system/:id-:hash:filename",
    storage: (:filesystem),
    hash_secret:  "ThisIsThePiSecretStringForCoverPage"
  }

  TEMPFILE_OPTIONS = {
    path:    ":rails_root/public/temp/:filename",
    url:     "public/temp/:filename",
    storage: (:filesystem),
    hash_secret:  "ThisIsThePiSecretStringForOriginFile"
  }

  delegate :chapter_id, to: :bookmark, prefix: true, allow_nil: true

  has_attached_file :cover, COVER_OPTIONS
  has_attached_file :origin_file, TEMPFILE_OPTIONS

  validates_attachment_content_type :cover,
                                    content_type: %w(image/jpeg image/png image/jpg)

  validates_attachment_content_type :origin_file,
                                    content_type: %w(text/plain application/pdf)

  def cover_img_url
    ActionController::Base.helpers.asset_path("default_book_cover.jpeg")
  end

  def has_bookmark
    bookmark.present?
  end

  def chapters_size
    chapters.size
  end

  def self.search(search)
    wildcard = "%#{search}%"
    where("name || author || category ILIKE :search", search: wildcard)
  end

  aasm column: "state" do
    state :init, initial: true
    state :uploading
    state :chatpers_building
    state :done

    event :upload do
      transitions from: [:init, :done], to: :uploading, after: :save_temp_file
    end

    event :publish do
      transitions from: :uploading, to: :chatpers_building
      after do
        build_chapters
      end
    end

    event :finish_build do
      transitions from: :chatpers_building, to: :done
      after do
        remove_temp_file
      end
    end
  end

  private

  def randomize_file_name
    extension = File.extname(origin_file_file_name).downcase
    self.origin_file.instance_write(:file_name, "#{SecureRandom.uuid}#{extension}")
  end

  def set_randomize_name_condition
    init? && origin_file.present? && origin_file_file_name_changed?
  end

  def uploading?
    state == 'uploading' && state_changed?
  end

  def save_temp_file(params)
    update(origin_file: params[:file])
  end

  def build_chapters
    BookBuildingWorker.perform_in(5.seconds, origin_file.url, id)
  end

  def remove_temp_file
    update origin_file: nil
  end
end
