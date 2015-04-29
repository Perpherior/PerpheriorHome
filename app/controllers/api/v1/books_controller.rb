module Api
  module V1
    class BooksController < Api::ApiController
      def index
        @books = collection
      end

      def show
        @stop = resource
      end

      def create
        @folder_tag = collection.build
        @folder_tag.update book_params
      end

      private

      def book_params
        params.require(:book).permit(:name, :author, :word_count)
      end

      def collection
        begin_of_association_chain.books
      end

    end
  end
end