module Api
  module V1
    class BooksController < Api::ApiController
      def index
        @books = collection
      end

      def show
        @book = resource
      end

      def create
        @book = collection.build
        @book.update book_params
      end

      def upload_cover
        @book = resource
        @book.update(cover: params[:file])

        render json: { cover_img_url: @book.cover_img_url }
      end

      private

      def book_params
        params.require(:book).permit(:name, :author, :word_count, :category, :cover)
      end

      def collection
        begin_of_association_chain.books
      end
    end
  end
end