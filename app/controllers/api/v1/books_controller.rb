module Api
  module V1
    class BooksController < Api::ApiController
      def index
        @books = ::Pagination.new(collection, params).call
        @total = collection.count
      end

      def show
        @book = resource
      end

      def destroy
        resource.destroy
      end

      def update
        @book = resource
        updated = @book.update book_params

        respond_with @book, status: status(updated)
      end

      def create
        @book = collection.build
        @book.update book_params
      end

      def upload_cover
        @book = resource
        @book.update(cover: params[:file])
      end

      def upload_book
        resource.upload!(params)
      end

      private

      def book_params
        params.require(:book).permit(:name, :author, :word_count, :category)
      end

      def collection
        begin_of_association_chain.books
      end
    end
  end
end