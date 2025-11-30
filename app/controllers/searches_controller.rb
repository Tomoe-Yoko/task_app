class SearchesController < ApplicationController
  def search
    @title = params[:title]
    @tasks = if @title.present?
               Task.where("title like '%#{@title}%'") # 正規表現
             else
               Task.all
             end
    render "tasks/index"
  end
end
