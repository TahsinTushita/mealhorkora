class StatusController < ApplicationController
    def update
        if current_user.update_attributes(meal_params)
            flash[:success] = "Your meal status have been saved!"
            redirect_to current_user
        else
            render html: current_user.errors.inspect
        end
    end

    def meal_params
        params.require(:user).permit(:takes_dinner, :takes_lunch)
    end
end
