class UsersController < ApplicationController
  before_action(:logged_in_user, only: [:edit, :update, :show, :forgot_password])
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy]

  def index
    #@users=User.all
    @users = User.paginate(page: params[:page])
  end

  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end


  def forgot_password
    params[:passwrod]
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
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
    debugger
  	@user = User.new(user_params)
  	if @user.save
      @user.send_activation_email
      flash[:info]="Please check your mail for account activation link"
      custom_hash = { testing: '1234'}
      redirect_to root_path
  	else
  		render 'new'
  	end
  end

  

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

  def user_params
    debugger
  	params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless @user == current_user
  end

  def admin_user
    redirect_to root_path unless current_user.admin?
  end
end
