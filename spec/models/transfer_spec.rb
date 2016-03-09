require 'rails_helper'

RSpec.describe Transfer, type: :model do
  context "Transferências válidas" do
    it "Transferência válida?" do
      transfer = Transfer.new
      transfer.user_id = 1
      transfer.origin_account = 1
      transfer.destiny_account = 2
      transfer.value = 100
      transfer.origin_acc_number = "11111"
      transfer.destiny_acc_number = "22222"
      transfer.action = "Transferência"
      transfer.tax = 5

      expect(transfer.valid?).to be_truthy
    end
    it "Transferência inválida sem id do usuário?" do
      transfer = Transfer.new
      transfer.user_id = nil
      transfer.origin_account = 1
      transfer.destiny_account = 2
      transfer.value = nil
      transfer.origin_acc_number = "11111"
      transfer.destiny_acc_number = "22222"
      transfer.action = "Transferência"
      transfer.tax = 5

      expect(transfer.valid?).to be_falsey
    end
    it "Transferência inválida conta?" do
      transfer = Transfer.new
      transfer.user_id = 1
      transfer.origin_account = nil
      transfer.destiny_account = nil
      transfer.value = 100
      transfer.origin_acc_number = "11111"
      transfer.destiny_acc_number = "22222"
      transfer.action = "Transferência"
      transfer.tax = 0

      expect(transfer.valid?).to be_falsey
    end
    it "Transferência válida sem conta destino?" do
      transfer = Transfer.new
      transfer.user_id = 1
      transfer.origin_account = 1
      transfer.destiny_account = nil
      transfer.value = 100
      transfer.origin_acc_number = "11111"
      transfer.destiny_acc_number = "22222"
      transfer.action = "Transferência"
      transfer.tax = 5

      expect(transfer.valid?).to be_truthy
    end
    it "Transferência válida sem conta origem?" do
      transfer = Transfer.new
      transfer.user_id = 1
      transfer.origin_account = nil
      transfer.destiny_account = 2
      transfer.value = 100
      transfer.origin_acc_number = "11111"
      transfer.destiny_acc_number = "22222"
      transfer.action = "Transferência"
      transfer.tax = 0

      expect(transfer.valid?).to be_truthy
    end
    it "Transferência inválida sem valor?" do
      transfer = Transfer.new
      transfer.user_id = 1
      transfer.origin_account = 1
      transfer.destiny_account = 2
      transfer.value = nil
      transfer.origin_acc_number = "11111"
      transfer.destiny_acc_number = "22222"
      transfer.action = "Transferência"
      transfer.tax = 5

      expect(transfer.valid?).to be_falsey
    end
    it "Transferência inválida sem número conta?" do
      transfer = Transfer.new
      transfer.user_id = 1
      transfer.origin_account = 1
      transfer.destiny_account = 2
      transfer.value = 100
      transfer.origin_acc_number = nil
      transfer.destiny_acc_number = nil
      transfer.action = "Transferência"
      transfer.tax = 0

      expect(transfer.valid?).to be_falsey
    end
    it "Transferência válida sem número conta origem?" do
      transfer = Transfer.new
      transfer.user_id = 1
      transfer.origin_account = 1
      transfer.destiny_account = 2
      transfer.value = 100
      transfer.origin_acc_number = nil
      transfer.destiny_acc_number = "22222"
      transfer.action = "Transferência"
      transfer.tax = 5

      expect(transfer.valid?).to be_truthy
    end
    it "Transferência válida sem número conta destino?" do
      transfer = Transfer.new
      transfer.user_id = 1
      transfer.origin_account = 1
      transfer.destiny_account = 2
      transfer.value = 100
      transfer.origin_acc_number = "11111"
      transfer.destiny_acc_number = nil
      transfer.action = "Transferência"
      transfer.tax = 5

      expect(transfer.valid?).to be_truthy
    end
    it "Transferência inválida sem ação?" do
      transfer = Transfer.new
      transfer.user_id = 1
      transfer.origin_account = 1
      transfer.destiny_account = 2
      transfer.value = 100
      transfer.origin_acc_number = "11111"
      transfer.destiny_acc_number = "22222"
      transfer.action = nil
      transfer.tax = 5

      expect(transfer.valid?).to be_falsey
    end
    it "Transferência inválida sem taxa?" do
      transfer = Transfer.new
      transfer.user_id = 1
      transfer.origin_account = 1
      transfer.destiny_account = 2
      transfer.value = 100
      transfer.origin_acc_number = "11111"
      transfer.destiny_acc_number = "22222"
      transfer.action = "Transferência"
      transfer.tax = nil

      expect(transfer.valid?).to be_falsey
    end
  end
end
