module ApplicationHelper
  def amount_with_commision(amount)
    return (amount + (amount * @payment_setting.buyer_post_commision)).round
  end


  def transfer_translate(transfer_mode)
    if transfer_mode == true
      return "振込済"
    else
      return "未振込"
    end
  end

  def time_translate(time)
    return time.strftime("%Y年 %m月%d日")
  end
end
