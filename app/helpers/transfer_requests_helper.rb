module TransferRequestsHelper
  def translate_bank_type(type)
    if type == "usually"
      return "普通"
    else
      return "当座"
    end
  end
end
