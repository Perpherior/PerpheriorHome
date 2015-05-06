class Pagination < Struct.new(:collection, :params)
  def call
    collection
      .order(params[:order])
      .page(params[:page])
      .per(params[:per_page])
  end
end
