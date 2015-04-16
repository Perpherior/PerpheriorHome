module Api
  module V1
    class ZooStopsController < Api::ApiController
      def index
        @stops = collection
      end

      def create
        @folder_tag = collection.build
        @folder_tag.update folder_tag_params
      end

      private

      def zoo_stop_params
        params.require(:zoo_stop).permit(:name, :latitude, :longitude)
      end

      def collection
        begin_of_association_chain.zoo_stops
      end

    end
  end
end