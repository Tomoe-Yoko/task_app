module Admin
  class UsersController < ApplicationController
    before_action :set_user, only: %i[edit update destroy]
    def index
      @users = User.includes(:tasks) # N+1問題対策
    end

    def show
      @user = User.includes(:tasks).find(params[:id])
      @tasks = @user.tasks
      @pagy, @tasks = pagy(@tasks, limit: 5)
    end

    def new
      @user = User.new
    end

    def edit; end

    def create
      @user = User.new(user_params)
      if @user.save
        flash[:success] = "ユーザーが作成されました"
        redirect_to admin_users_path, status: :see_other
      else
        render :new, status: :unprocessable_content
      end
    end

    def update
      password_blank_delete
      if @user.update(user_params)
        redirect_to admin_users_path
        flash[:success] = "ユーザーを更新しました"
      else
        render :edit
      end
    end

    def destroy
      @user.destroy!
      flash[:notice] = "ユーザーを削除しました。"
      redirect_to admin_users_path, status: :see_other
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # パスワード未入力なら更新除外
    def password_blank_delete
      return if params[:user][:password].present?

      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
  end
end
