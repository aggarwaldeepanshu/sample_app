class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :show]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy]

  def index
    #@users=User.all
    @users = User.paginate(page: params[:page])
  end

  def new
  	@user=User.new
  end

  def show
  	@user=User.find(params[:id])
  end


  def edit
    @user=User.find(params[:id])
  end

  def update
    @user=User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success]="Profile Updated!"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success]="User Deleted Successfully!"
    redirect_to users_path
  end

  def create
  	@user=User.new(user_params)
  	if @user.save
      #log_in @user
  		#flash[:success] = "Welcome to the Sample App!"
  		#redirect_to @user
      @user.send_activation_email
      flash[:info]="Please check your mail for account activation link"
      redirect_to root_path
  	else
  		render 'new'
  	end
  end



  private

  def user_params
  	params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
  end

  def logged_in_user
    unless logged_in?
      flash[:danger]="Please log in first"
      redirect_to login_path
  end
end

  def correct_user
    @user=User.find(params[:id])
    redirect_to(root_path) unless @user==current_user
  end

  def admin_user
    redirect_to root_path unless current_user.admin?
  end
end
