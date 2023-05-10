module Api
  module V1
    class ReservationsController < ApplicationController
      # TODO: Add access_token validation here    
      def create
        create_or_update
      end

      def update
        create_or_update
      end

      private

      def create_or_update
        begin
          @reservation = ReservationsManager.create_or_update JSON.parse(request.raw_post, symbolize_names: true)
          return render json: @reservation, adapter: :json  
        rescue Exception => e
          return render json: { error: e.message, request: request.raw_post }, status: :not_acceptable
        end
      end
    end
  end
end