class Admin::UsersController < Admin::BaseController

  before_filter :find_user, :only => [:show, :edit, :update, :destroy]

  def index
    @users = User.all(:order => "email")
  end
  
  def new
    @user = User.new
  end
  
  def edit
  
  end
  
  def update
    
    # Devise method to stop email from sending out another email asking user
    # to confirm their new email address when the update action executes
    @user.skip_reconfirmation!
    
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    if @user.update_attributes(params[:user], :as => :admin)
  
    flash[:notice] = "User has been updated."
    redirect_to admin_users_path
    else
      flash[:alert] = "User has not been updated."
      render :action => "edit"
    end
  end

  
  def create
    @user = User.new(params[:user], :as => :admin)
    if @user.save
      flash[:notice] = "User has been created."
      redirect_to admin_users_path
    else
      flash.now[:alert] = "User has not been created."
      render :action => "new"
    end
  end
  
  def show
    #lbelater - empty for now
  end
  
  def destroy
    if @user == current_user
    flash[:alert] = "You cannot delete yourself!"
    else
      @user.destroy
      flash[:notice] = "User has been deleted."
    end
    redirect_to admin_users_path
  end



  
end # end of class
 
# private area is always at the bottom, and IS after the class definition
# unusual but private does not have an 'end' to it!!!
private

  def find_user
    @user = User.find(params[:id])
  end





