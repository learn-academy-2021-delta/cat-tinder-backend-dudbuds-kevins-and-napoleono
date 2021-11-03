class DudsController < ApplicationController

    def index
        duds = Dud.all
        render json: duds
    end
  
    def create
      dud = Dud.create(dud_params)
      if dud.valid?
        render json: dud
      else
        render json: dud.errors, status: 422
      end
    end
  
    def update
      dud = Dud.find(params[:id])
      dud.update(dud_params)
      if dud.valid?
        render json: dud
      else
        render json: dud.errors, status: 422
      end
    end
  
    def destroy
      dud = Dud.find(params[:id])
      dud.destroy
      render json: dud
    end
  
    private
  def dud_params
    params.require(:dud).permit(:name, :age, :hobbies)
  end

end
