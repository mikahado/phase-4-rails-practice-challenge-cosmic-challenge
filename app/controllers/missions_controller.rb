class MissionsController < ApplicationController

    def create
        mission = Mission.create!(mission_params)
        render json: mission.planet, status: :created
    end

    def length
        missions = Mission.where('length_in_days > ?', 30)
        render json: missions
    end

    def search_length
        missions = Mission.where('length_in_days > ?', params[:days])
        render json: missions
    end

   def pluto_missions
        missions = Mission.joins(:scientist).where(scientists: { field_of_study: 'Pluto Specialist'})
        render json: missions
   end


    private 

    def mission_params
        params.permit(:name, :scientist_id, :planet_id)
    end

end
