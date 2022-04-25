module ApplicationHelper
  def amount_with_commision(amount)
    return (amount + (amount * @payment_setting.buyer_post_commision)).round
  end

end
