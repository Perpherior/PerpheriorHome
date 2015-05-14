module Api
  module V1
    class BookmarksController < Api::ApiController
      def show
        @bookmark = resource
      end

      def update_bookmark
        bookmark = resource || begin_of_association_chain.build_bookmark
        bookmark.update bookmark_params
      end

      private

      def bookmark_params
        params.require(:bookmark).permit(:book_id, :chapter_id, :offset)
      end

      def resource
        begin_of_association_chain.bookmark
      end

      def begin_of_association_chain
        current_admin.books.find(params[:book_id])
      end
    end
  end
end