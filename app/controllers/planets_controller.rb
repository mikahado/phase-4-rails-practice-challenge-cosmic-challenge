class PlanetsController < ApplicationController

    def index
        render json: Planet.all
    end

    def search
        planet = Planet.where('LOWER(name) LIKE ?', params[:search].downcase)
        render json: planet
    end

end
