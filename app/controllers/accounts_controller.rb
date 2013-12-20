class AccountsController < ApplicationController
  before_action :find_user
  layout "user"

  def edit
  end

  def update
    if @user.authenticate(params[:user][:password])
      @user.skip_password = true
      @user.update(name: params[:user][:name])
      flash[:success] = '修改成功！'
      redirect_to user_path
    else
      flash.now[:danger] = '修改失败，请输入正确密码！'
      render 'edit'
    end
  end

  def change_password
  end

  def update_password
    if @user.authenticate(params[:user][:old_password])
      if @user.update(update_new_password)
        flash[:success] = '修改成功！'
        redirect_to user_path
      else
        flash.now[:danger] = '修改失败，请重新输入！'
        render 'change_password'
      end
    else
      flash.now[:danger] = '修改失败，请重新输入！'
      render 'change_password'
    end
  end

  private
    def find_user
      @user = current_user
    end

    def users_params
      params.require(:user).permit(:name, :password, :password_confirmation)
    end
  
    def update_new_password
      params.require(:user).permit(:password, :password_confirmation)
    end
end