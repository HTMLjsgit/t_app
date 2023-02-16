class SearchesController < ApplicationController
  def index

  end
  def search
    p "-------------------"
    search_type = params[:search_type]
    search_value = params[:search_value]
    if search_type == "posts"

      redirect_to posts_path(q: search_value)
    elsif search_type == "users"

      redirect_to users_path(q: search_value)
    end
  end
end
