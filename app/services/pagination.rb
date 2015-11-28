class Pagination < Struct.new(:collection, :params)
  def call
    filter_collection
      .order(params[:order])
      .page(params[:page])
      .per(params[:per_page])
  end

  private
  # filter collection with search words
  def filter_collection
    params[:key_words].present? ? collection.search(params[:key_words]) : collection
  end
end
