class RealsController < ApplicationController
  impressionist :actions=> [:index]

  def index
    @reals = Real.all.order(created_at: :desc)
  end

  def show
    @real = Real.find_by(id: params[:id])
    @user = @real.user
    @real_comments = @real.real_comments.all.order(created_at: :desc)
    @real_comment = RealComment.new
    print current_user.id
    print @user.id
    print @real.user_id
    if current_user.present? then
      if (current_user.id != @real.user_id) then
        print "nomore"
        impressionist(@real)
      end
    end
  end

  def new
    @real = Real.new
  end

  def create
    @real = Real.new(real_params)
    @real.save!
    if params[:item].present?
      if params[:item][:images_attributes]
        for i in 0..params[:item][:images_attributes].length - 1
          @image_real = ImageReal.new(number: params[:item][:images_attributes].length,
                            image_url: params[:item][:images_attributes][i][:image_url],
                            picture: params[:item][:images_attributes][i][:image_url].read,
                            real_id:  @real.id
                            )
          @image_real.save
        end
      end
    else
      @image_real = ImageReal.new(number: 0,
                            image_url: "",
                            picture: "",
                            real_id:  @real.id
                            )
      @image_real.save
    end

    redirect_to(reals_path)
  end

  def edit
    @real = Real.find_by(id: params[:id])
  end

  def update
    @real = Real.find_by(id: params[:id])
    @real.content = params[:content]
    @real.save
    redirect_to(reals_path)
  end

  def destroy
    @real = Real.find_by(id: params[:id])
    @real.destroy
    redirect_to(reals_path)
  end

  private
  def real_params
    params.require(:real).permit(:content, :user_id, images: [])
  end
end
