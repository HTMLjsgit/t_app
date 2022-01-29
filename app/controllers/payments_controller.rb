class PaymentsController < ApplicationController
  before_action :post_find, only: [:post_payment]
  def index
    @payments = current_user.payments
  end
  def post_payment
    # payment = current_user.payments.new()
    sender = nil
  #   if user_signed_in?
  #     sender = Stripe::Customer.create({
  #       name: current_user.name,
  #       email: current_user.email,
  #       source: params[:stripeToken]
  #     })
  #  else
  #    sender = Stripe::Customer.create({
  #      source: params[:stripeToken]
  #    })
  #  end
    Stripe::Charge.create(
      amount: 100,
      currency: "jpy",
      source: params[:stripeToken],
      description: "#{@post.content.truncate(10)}のご購入"
    )
    redirect_to @post

  end


  private

  def post_find
    @post = Post.find params[:post_id]
  end
end
