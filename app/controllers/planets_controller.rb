class PlanetsController < ApplicationController

    def index
        render json: Planet.all
    end

    def search
        planet = Planet.where('name = ?', + params[:search] )
        render json: planet
    end

end
