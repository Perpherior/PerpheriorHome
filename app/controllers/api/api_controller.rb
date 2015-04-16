module Api
  class ApiController < ::ApplicationController
    respond_to :json

    private

    def resourece
      collection.find(params[:id])
    end

    def begin_of_association_chain
      current_admin    
    end
  end
end