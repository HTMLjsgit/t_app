class PaymentsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :post_payment]
  before_action :post_find, only: [:post_payment]
  before_action :already_payment_check, only: [:post_payment]
  def index
    @payments = current_user.payments
  end
  def post_payment
    sender = nil
    # if user_signed_in?
    #   # sender = Stripe::Customer.create({
    #   #   name: current_user.name,
    #   #   email: current_user.email,
    #   #   source: params[:stripeToken]
    #   # })
    # end
    mine_commision = @post.commission
    charge = Stripe::Charge.create(
      amount: @post.amount + mine_commision, #手数料を足してあげる
      currency: "jpy",
      source: params[:stripeToken],
      description: "#{@post.content.truncate(10)}のご購入"
    )
    # payment(支払い履歴テーブル)のレコード作成。
    payment = current_user.payments.create!(
      receipt_url: charge.receipt_url, #領収書のURL
      post_id: @post.id,
      charge_id: charge.id,
      currency: "jpy",
      stripe_commission: 0.036,
      stripe_amount_after_subtract_commision: @post.amount * 0.036,
      mine_subtract_commision_amount: mine_commision, 
      mine_commision: mine_commision, #手数料
      stripe_and_mine_subtract_commision_amount: @post.amount * (0.036 + 0.15), # 記事の値段 × (このサービス上の手数料 + stripeの手数料)
      commision_amount_result: @post.amount + mine_commision, #手数料と記事の値段を合わせた結果
      amount: @post.amount
    )
    redirect_to @post

    # stripe関連でエラーが起こった場合
    rescue Stripe::CardError => e
      flash[:payment_error_message] = "#決済(stripe)でエラーが発生しました。#{e.message}"
      redirect_to @post
    # Invalid parameters were supplied to Stripe's API
    rescue Stripe::InvalidRequestError => e
      flash.now[:payment_error_message] = "決済(stripe)でエラーが発生しました（InvalidRequestError）#{e.message}"
      redirect_to @post

    # Authentication with Stripe's API failed(maybe you changed API keys recently)
    rescue Stripe::AuthenticationError => e
      flash.now[:payment_error_message] = "決済(stripe)でエラーが発生しました（AuthenticationError）#{e.message}"
      redirect_to @post

    # Network communication with Stripe failed
    rescue Stripe::APIConnectionError => e
      flash.now[:payment_error_message] = "決済(stripe)でエラーが発生しました（APIConnectionError）#{e.message}"
      redirect_to @post

    # Display a very generic error to the user, and maybe send yourself an email
    rescue Stripe::StripeError => e
      flash.now[:payment_error_message] = "決済(stripe)でエラーが発生しました（StripeError）#{e.message}"
      redirect_to @post

    # stripe関連以外でエラーが起こった場合
    rescue => e
      flash.now[:payment_error_message] = "エラーが発生しました#{e.message}"
      redirect_to @post
  end


  private

  def post_find
    @post = Post.find params[:post_id]
  end

  def already_payment_check
    # 支払いができている場合 もう一度支払う必要はないので showに飛ばす
    if current_user.payments.find_by(post_id: @post.id, user_id: current_user.id).present?
      # 強制的にトップに戻す。
      redirect_to @post and return
    end
  end
end
