require 'rails_helper'

RSpec.describe Transfer, type: :model do
  context "Transferências válidas" do
    it "Transferência válida?" do
      transfer = Transfer.new
      transfer.user_id = 1
      transfer.origin_account = 1
      transfer.destiny_account = 2
      transfer.value = 100
      transfer.action = "Transferência"

      expect(transfer.valid?).to be_truthy
    end
    # it "Transferência inválida?" do
    #   transfer = Transfer.new
    #   transfer.user_id = 1
    #   transfer.origin_account = nil
    #   transfer.destiny_account = nil
    #   transfer.value = 100
    #   transfer.action = "Transferência"

    #   expect(transfer.valid?).to be_falsey
    # end
  end
end
