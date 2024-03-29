class LunchManagersController < ApplicationController
    before_action :admin_user, only: [:new,:create,:destroy]
    def new
        @users = User.where(takes_lunch: 1)
        @lunch_meals = LunchMeal.all
    end

    def create
        user = User.find(params[:lunch][:user_id])
        lunch_meal_id = params[:lunch_meal_id]
        params[:lunch][:lunch_meal_id] = lunch_meal_id
        unless ( helpers.had_lunch_today?(user) && !user.nil?)
            lunch = user.lunches.build
            time = params[:lunch][:date].split(' ')
            params[:lunch][:day] = time.first
            params[:lunch][:month] = time.second
            params[:lunch][:year] = time.third
            if !user.balance.nil?
                if user.balance>300
                    if lunch.update_attributes(lunch_params)
                        user.update_balance(user.balance-LunchMeal.find(lunch_meal_id).cost)
                        user.save!
                        flash[:success] = "Lunch confirmed"
                    end
                else
                    flash[:danger] = "Insufficient account balance"
                end
            else
                flash[:danger] = "Insufficient account balance"
            end

        end
        redirect_back_or lunch_manager_path
    end

    def destroy
        # LunchMeal.find(params[:lunch_meal][:lunch_id]).destroy
        # flash[:success] = "Meal deleted!"
        # redirect_to create_new_lunch_menu_path
    end

    def new_meal
        @lunch_meal = LunchMeal.new
        @lunch_meals = LunchMeal.all
    end

    def edit
        # @lunch_meal = LunchMeal.find(params[:lunch_meal][:lunch_id])
    end

    def update
        # @lunch_meal = LunchMeal.find(params[:lunch_meal][:lunch_id])
        # if @lunch_meal.update_attributes(:lunch_meal)
        #     flash[:success] = "Meal updated!"
        #     redirect_to create_new_lunch_menu_path
        # else
        #     redirect_to 'edit'
        # end
    end

    def create_meal
        items = params[:lunch_meal][:items]
        cost = params[:lunch_meal][:cost]
        LunchMeal.create!(items: items, cost: cost)
        flash[:success] = "New lunch menu created!"
        redirect_to lunch_manager_path
    end

    private

    def lunch_params
        params.require(:lunch).permit(:day,:month,:year,:lunch_meal_id)
    end

    def admin_user
        if current_user.superuser?
        return current_user
        else redirect_to root_url
        end
    end

end
