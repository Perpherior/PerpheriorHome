module Api
  module V1
    class ChaptersController < Api::ApiController
      def index
        @chapters = collection.order(:id)
      end

      private

      def chapter_params
        params.require(:chapter).permit(:name, :book_id, :word_count, :content)
      end

      def collection
        begin_of_association_chain.chapters
      end

      def begin_of_association_chain
        current_admin.books.find(params[:book_id])
      end
    end
  end
end