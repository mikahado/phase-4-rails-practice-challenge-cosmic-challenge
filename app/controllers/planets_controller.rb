class PlanetsController < ApplicationController

    def index
        render json: Planet.all
    end

    def show
        render json: @scientist, serializer: ScientistWithPlanetsSerializer
    end


end
