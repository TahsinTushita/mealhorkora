class UsersController < ApplicationController

    before_action :logged_in_user, only: [:edit, :update, :show]
    before_action :correct_user, only: [:edit, :update]

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            log_in @user
            flash[:success] = "SignUp Success!"
            redirect_to current_user
        else
            render 'new'
        end
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        if @user.update_attributes(user_params)
            flash[:success] = "Profile updated!"
            redirect_to @user
        else
            render 'edit'
        end
    end

    def destroy
        User.find(params[:id]).destroy
        flash[:success] = "User deleted!"
        redirect_to users_url
    end

    def index
         # @users = User.paginate(page: params[:page])
         @users = if params[:term]
                      User.where('name LIKE ?', "%#{params[:term]}%").paginate(page: params[:page])
                  else
                      User.paginate(page: params[:page])
                  end
    end

    def show
        @user = User.find(params[:id])   
        @preferrences = @user.preferrences
    end

    private

    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :city,
                                     :address, :religion, :date_of_birth, :profession, :phone_no, :term)
    end

    def logged_in_user
        unless logged_in?
            flash[:danger] = "Please log in!"
            redirect_to signin_url
        end
    end

    private

    def correct_user
        @user = User.find(params[:id])
        redirect_to current_user unless current_user?(@user)
    end
end
