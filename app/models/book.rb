class Book < ActiveRecord::Base
  include AASM
  include CloudinaryOperations

  belongs_to :admin
  has_many :chapters, dependent: :destroy
  has_one :bookmark, dependent: :destroy

  # after_update :publish!, if: :uploading?
  after_update :build_chapters, if: :buildable?

  delegate :chapter_id, to: :bookmark, prefix: true, allow_nil: true

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
    state :chapters_building
    state :done

    event :build do
      transitions from: [:init, :done], to: :chapters_building
      after do
        build_chapters
      end
    end

    event :finish_build do
      transitions from: :chapters_building, to: :done
      after do
        remove_temp_file
      end
    end
  end

  # private

  def buildable?
    source_url.present? && source_url_changed?
  end

  def build_chapters
    BookBuildingWorker.perform_async(id, source_url)
  end

  def remove_temp_file
    update source_url: nil
  end
end
