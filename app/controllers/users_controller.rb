class UsersController < ApplicationController

  def new
    if current_user
      redirect_to profile_path(current_user)
    else
      @user = User.new
      render :new
    end
  end

  def create
    if current_user 
      redirect_to profile_path(current_user)
    else 
      user = User.new(user_params)
      if user.save 
        session[:user_id] = user.id
        if user.user_type
          redirect_to new_charity_path 
        else
        redirect_to profile_path(current_user)
        end
      else 
      redirect_to signup_path

      end
    end
  end

  def show
    @user = User.find(params[:id])
    render :show

  end

  def edit
    @user = User.find(current_user)
    render :edit
  end

  def update
    user = User.find(params[:id])
    if current_user
      # flash[:notice] = "Successfully updated profile!"
      user.update_attributes(user_params)
      redirect_to profile_path(current_user)
    else
      flash[:error] = user.errors.full_messages.join(', ')
      redirect_to edit_profile_path
    end
  end

  def destroy
    @user = User.find(params[:id])
    if current_user
      # flash[:error] = "Successfully deleted profile!"
      @user.destroy
      session[:user_id] = nil
      redirect_to root_path
    end
  end
  
  private 
    def set_user
      @user = User.find(params[:id])
    end


    def user_params 
      params.require(:user).permit(:first_name, :last_name, :password, :phone, :user_type, :email, :avatar)
    end
end
