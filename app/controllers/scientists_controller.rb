class ScientistsController < ApplicationController

    before_action :set_scientist, only: [:show, :update, :destroy]

    def index
        render json: Scientist.all
    end

    def show
        render json: @scientist, serializer: ScientistWithPlanetsSerializer
    end

    def create
        scientist = Scientist.create!(scientist_params)
        render json: scientist, status: :created
    end

    def update
        @scientist.update!(scientist_params)
        render json: @scientist, status: :accepted
    end

    def destroy
        @scientist.destroy
        head :no_content
    end

    def pluto
        scientists = Scientist.where('field_of_study = ?', 'Pluto Specialist')
        render json: scientists
    end

    def pluto_missions
        # missions = Scientist.joins(:missions).where('field_of_study = ?', 'Pluto Specialist')
        scientists = Scientist.where('field_of_study = ?', 'Pluto Specialist')
       
        missions = scientists.map{|s| s.missions }

        render json: missions
    end

    private

    def set_scientist
        @scientist = Scientist.find(params[:id])
    end

    def scientist_params
        params.permit(:name, :field_of_study, :avatar)
    end

end
