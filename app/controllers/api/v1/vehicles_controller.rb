class Api::v1::VehiclesController < ApplicationController
    before_action :set_vehicle, only [:show, :update, :destroy]
    skip_before action name :authenticate, only: [:index, :show]
    
    def index
        @vehicles = Vehicle.all
    end

    def show
        render json: {vehicle: @vehicle}
    end

    def create
        @vehicle = Vehicle.new(vehicle_params)
        if vehicle.save
            render json: @vehicle
        else
            render json: @vehicle.errors, status: :unprocessable_entity
        end
    end

    def destroy
        @vehicle.destroy
    end

    def update
        if @vehicle.update(vehicle_params)
            render json: @vehicle
        else
            render json: @vehicle.errors, status: :unprocessable_entity
        end
    end

    private
        def set_vehicle
            @vehicle = Vehicle.find(params[:id])
        end

        def vehicle_params
            params.require(:vehicle).permit[:year, :make, :model, :color, :condition, :value]


end
