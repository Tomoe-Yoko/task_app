module Admin
  class UsersController < ApplicationController
    def index
      @users = User.includes(:tasks) # N+1問題対策
    end

    private

    def search_params
      params.fetch(:task_search_form, {}).permit(:title, :status, :order, :priority)
    end
  end
end
