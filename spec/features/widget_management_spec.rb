require 'rails_helper'
require 'capybara/rspec'

feature "Testando Views Operações" do

  scenario "Operação Depósito inválida?" do
    visit deposit_path
    within "form" do
      find(".js-acc-dtn").set "1111"
      find(".js-dep-val").set "50"
    end
    click_button "Depositar"
    expect(page).to have_content "Depósito não realizado."
  end

  scenario "Operação Depósito inválida sem conta?" do
    page.visit deposit_path
    page.within "form" do
      page.find(".js-acc-dtn").set ""
      page.find(".js-dep-val").set "50"
    end
    page.click_button "Depositar"
    expect(page).to have_content "Conta de destino não existe."
  end

  scenario "Operação Depósito inválida sem valor?" do
    page.visit deposit_path
    page.within "form" do
      page.find(".js-acc-dtn").set "1111"
      page.find(".js-dep-val").set ""
    end
    page.click_button "Depositar"
    expect(page).to have_content "Depósito não realizado."
  end

  # scenario "Operação Saque inválida?" do
  #   visit withdraw_path
  #   within "form" do
  #     find(".js-acc-org").set "1111"
  #     find(".js-wit-val").set "50"
  #     find(".js-wit-pwd").set "12345678"
  #   end
  #   click_button "Sacar"
  #   expect(page).to have_content "Saque não realizado."
  # end

  # scenario "Operação Saque inválida sem conta?" do
  #   visit withdraw_path
  #   within "form" do
  #     find(".js-acc-org").set ""
  #     find(".js-wit-val").set "50"
  #     find(".js-wit-pwd").set "12345678"
  #   end
  #   click_button "Sacar"
  #   expect(page).to have_content "Saque não realizado."
  # end

  # scenario "Operação Saque inválida sem valor?" do
  #   visit withdraw_path
  #   within "form" do
  #     find(".js-acc-org").set "1111"
  #     find(".js-wit-val").set ""
  #     find(".js-wit-pwd").set "12345678"
  #   end
  #   click_button "Sacar"
  #   expect(page).to have_content "Saque não realizado."
  # end

  # scenario "Operação Saque inválida sem senha?" do
  #   visit withdraw_path
  #   within "form" do
  #     find(".js-acc-org").set "1111"
  #     find(".js-wit-val").set "50"
  #     find(".js-wit-pwd").set ""
  #   end
  #   click_button "Sacar"
  #   expect(page).to have_content "Saque não realizado."
  # end

  # scenario "Operação Saldo válida?" do
  #   visit balance_path
  #   within "form" do
  #     find(".js-bal-acc").set "1111"
  #   end
  #   click_button "Solicitar"
  #   expect(page).to have_content "Saldo"
  # end

  # scenario "Operação Saldo inválida sem conta?" do
  #   visit balance_path
  #   within "form" do
  #     find(".js-bal-acc").set ""
  #   end
  #   click_button "Solicitar"
  #   expect(page).to have_content "Conta não existe."
  # end

  # scenario "Operação Nova Conta" do
  #   page.visit accounts_path
  #   page.within "form" do
  #     page.find(".js-usr-id", :visible=>false).set "1"
  #     page.find(".js-acc-num").set "4321"
  #     page.find(".js-acc-bal").set "25"
  #     page.find(".js-acc-sts", :visible=>false).set "Ativa"
  #   end
  #   page.click_button "Criar"
  #   page.should have_content "Conta criada."
  # end

  # scenario "Operação Extrato válida?" do
  #   page.visit extract_path
  #   page.within "form" do
  #     page.find(".js-acc-org").set "1111"
  #     page.find(".js-ini").set "01/03/2016"
  #     page.find(".js-fin").set "15/03/2016"
  #   end
  #   page.click_button "Solicitar"
  #   page.should have_content "Conta"
  # end

  # scenario "Operação Extrato inválida sem conta?" do
  #   page.visit extract_path
  #   page.within "form" do
  #     page.find(".js-acc-org").set ""
  #     page.find(".js-ini").set "01/03/2016"
  #     page.find(".js-fin").set "15/01/2016"
  #   end
  #   page.click_button "Solicitar"
  #   page.should have_content "Nenhum extrato encontrado para a data selecionada."
  # end

  # scenario "Operação Extrato inválida sem data inicial?" do
  #   page.visit extract_path
  #   page.within "form" do
  #     page.find(".js-acc-org").set "1111"
  #     page.find(".js-ini").set ""
  #     page.find(".js-fin").set "15/01/2016"
  #   end
  #   page.click_button "Solicitar"
  #   page.should have_content "Nenhum extrato encontrado para a data selecionada."
  # end

  # scenario "Operação Extrato inválida sem data final?" do
  #   page.visit extract_path
  #   page.within "form" do
  #     page.find(".js-acc-org").set "1111"
  #     page.find(".js-ini").set "01/03/2016"
  #     page.find(".js-fin").set ""
  #   end
  #   page.click_button "Solicitar"
  #   page.should have_content "Nenhum extrato encontrado para a data selecionada."
  # end

  # scenario "Operação Tranferência válida" do
  #   page.visit transfer_path
  #   page.within "form" do
  #     page.find(".js-tf-org").set "1111"
  #     page.find(".js-tf-dtn").set "2222"
  #     page.find(".js-tf-val").set "50"
  #     page.find(".js-tf-pwd").set "12345678"
  #   end
  #   page.click_button "Transferir"
  #   page.should have_content "Tranferência realizada."
  # end

  # scenario "Operação Tranferência inválida sem conta origem?" do
  #   page.visit transfer_path
  #   page.within "form" do
  #     page.find(".js-tf-org").set ""
  #     page.find(".js-tf-dtn").set "2222"
  #     page.find(".js-tf-val").set "50"
  #     page.find(".js-tf-pwd").set "12345678"
  #   end
  #   page.click_button "Transferir"
  #   page.should have_content "Tranferência não realizada."
  # end

  # scenario "Operação Tranferência inválida sem conta destino?" do
  #   visit transfer_path
  #   within "form" do
  #     page.find(".js-tf-org").set "1111"
  #     page.find(".js-tf-dtn").set ""
  #     page.find(".js-tf-val").set "50"
  #     page.find(".js-tf-pwd").set "12345678"
  #   end
  #   page.click_button "Transferir"
  #   page.should have_content "Tranferência não realizada."
  # end

  # scenario "Operação Tranferência inválida sem valor?" do
  #   page.visit transfer_path
  #   page.within "form" do
  #     page.find(".js-tf-org").set "1111"
  #     page.find(".js-tf-dtn").set "2222"
  #     page.find(".js-tf-val").set ""
  #     page.find(".js-tf-pwd").set "12345678"
  #   end
  #   page.click_button "Transferir"
  #   page.should have_content "Tranferência não realizada."
  # end

  # scenario "Operação Tranferência inválida sem senha?" do
  #   page.visit transfer_path
  #   page.within "form" do
  #     page.find(".js-tf-org").set "1111"
  #     page.find(".js-tf-dtn").set "2222"
  #     page.find(".js-tf-val").set "50"
  #     page.find(".js-tf-pwd").set ""
  #   end
  #   page.click_button "Transferir"
  #   page.should have_content "Tranferência não realizada."
  # end

end
