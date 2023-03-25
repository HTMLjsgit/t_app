class SearchesController < ApplicationController
  include CommonPaymentSettings
  before_action :payment_setting_get, only: [:index]
  def index
    @posts = []
    @users = []
    search_value = params[:search_value]
    search_type = params[:search_type]
    if search_type.present?
      if search_type == "posts"
        target_posts = Post.joins(:post_tags)
        posts_ids = []
        keywords = params[:search_value].split(/[[:blank:]]+/)
        keywords.each do |keyword|
          posts_ids += target_posts.where("post_tags.tag LIKE ?", "%#{keyword}%").pluck(:id)
        end
        @posts = Post.where(id: posts_ids).includes(:post_likes)
      elsif search_type == "users"
        users_ids = []
        keywords = search_value.split(/[[:blank:]]+/)
        keywords.each do |keyword|
          users_ids += User.where("username LIKE ?", "%#{keyword}%").pluck(:id)
        end
        @users = User.where(id: users_ids)
      elsif search_type == "reals"
        target_reals = Real.joins(:real_tags)
        reals_ids = []
        keywords = params[:search_value].split(/[[:blank:]]+/)
        keywords.each do |keyword|
          reals_ids += target_reals.where("real_tags.tag LIKE ?", "%#{keyword}%").pluck(:id)
        end
        @reals = Real.where(id: reals_ids).includes(:real_likes)
      end
    end
  end
  def autocomplete_search
    search_value = params[:search_value]
    if search_value.present?
      @posts = Post.joins(:post_tags).where("post_tags.tag LIKE ?", "%#{search_value}%").includes(:post_likes)
      @users = User.where("username LIKE ?", "%#{search_value}%")
      @reals = Real.joins(:real_tags).where("real_tags.tag LIKE ?", "%#{search_value}%").includes(:real_likes)
      posts = @posts.map{ |p| p.attributes }
      users = @users.map{ |p| p.attributes }
      reals = @reals.map { |p| p.attributes }

      posts.each_with_index do |post, index|
        posts[index].store("type", "post")
      end
      reals.each_with_index do |real, index|
        reals[index].store("type", "real")
        image_real = ImageReal.find_by(real_id: real["id"])
        if image_real.present?
          reals[index].store("image_real_url", image_real.picture.url)
        end
      end
      @users.each_with_index do |user, index|
        users[index].store("type", "user")
        if users[index]["avater"].present?
          users[index]["avater"] = user.avater.url
        end
      end
      if posts.present? || users.present? || reals.present?
        render json: posts.uniq + users.uniq + reals.uniq
      else
        render json: []
      end
    end
  end

end
