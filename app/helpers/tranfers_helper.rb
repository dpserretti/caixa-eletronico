module TranfersHelper
  def getNumber(account)
    conta = Account.find(account)
    return conta.number
  end
end
