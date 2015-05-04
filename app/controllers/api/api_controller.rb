module Api
  class ApiController < ::ApplicationController
    respond_to :json

    private

    def resource
      collection.find(params[:id])
    end

    def begin_of_association_chain
      current_admin    
    end

    def status(success)
      success ? 200 : 422
    end
  end
end