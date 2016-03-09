require 'rails_helper'

RSpec.describe Account, type: :model do
  context "Contas" do
    it "Conta válida?" do
      conta = Account.new
      conta.users_id = 1
      conta.number = "1234"
      conta.balance = 200
      conta.status = "Ativa"

      expect(conta.valid?).to be_truthy
    end
    it "Conta inválida sem id de usuario?" do
      conta = Account.new
      conta.users_id = nil
      conta.balance = 200
      conta.number = "1234"
      conta.status = "Ativa"

      expect(conta.valid?).to be_falsey
    end
    it "Conta inválida sem saldo?" do
      conta = Account.new
      conta.users_id = 1
      conta.balance = nil
      conta.number = "1234"
      conta.status = "Ativa"

      expect(conta.valid?).to be_falsey
    end
    it "Conta inválida sem número?" do
      conta = Account.new
      conta.users_id = 1
      conta.balance = 200
      conta.number = nil
      conta.status = "Ativa"

      expect(conta.valid?).to be_falsey
    end
    it "Conta inválida sem status?" do
      conta = Account.new
      conta.users_id = 1
      conta.balance = 200
      conta.number = "1234"
      conta.status = nil

      expect(conta.valid?).to be_falsey
    end
  end
end
