class SpicesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :stuff_not_found_response 

    def index
        spices = Spice.all
        render json: spices
    end

    def create
        spice = Spice.create(spice_param)
        render json: spice, status: :created
    end

    def update
        spice = find_spice
        spice.update(spice_param)
        render json: spice, status: :accepted
    end

    def destroy
        spice = find_spice
        spice.destroy
        render json: {}
    end


    private

    def find_spice
        Spice.find_by(params[:id])
    end

    def spice_param
        params.permit(:title, :image, :description, :notes, :rating)
    end

    def stuff_not_found_response
        render json: { error: "Spice Not Found" }, status: :not_found
    end
end
