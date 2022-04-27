class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_user_auth, only: [:index, :post_payment]
  before_action :post_find, only: [:post_payment]
  before_action :already_payment_check, only: [:post_payment]
  before_action :payment_setting_get, only: [:post_payment]
  include CommonPaymentSettings
  def index
    @payments = current_user.payments
  end

  def post_payment
    sender = nil

    commision = (@payment_setting.stripe_commission + @payment_setting.consumption_tax) #消費税 + Stripe手数料

    receipt_commision = (@payment_setting.buyer_post_commision - commision) #受取金率

    receipt_commision = BigDecimal((receipt_commision).to_s).ceil(3).to_f
    commision = BigDecimal((commision + receipt_commision).to_s).to_f.round(2) #手数料15%
    charge = Stripe::Charge.create(
      amount: @post.amount + (@post.amount * commision).round, #手数料を足してあげる
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
      commision_result: commision, #手数料
      receipt_commision: receipt_commision, #手数料のうち、受け取れる額,
      amount: @post.amount,
      payment_date: Time.now
    )
    sale = @post.user.sales.create!(payment_id: payment.id, transfer: false, post_id: @post.id)
    payment.update(sale_id: sale.id)
    redirect_to @post

    # stripe関連でエラーが起こった場合
    rescue Stripe::CardError => e
      flash.now[:payment_error_message] = "決済(stripe)でエラーが発生しました。#{e.message}"
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
      redirect_to post_explanation_post_path(@post) and return
    end
  end


  def check_user_auth
    if current_user.present?
      print true
    else
      new_user_session_path
    end
  end
end
