require 'rails_helper'
require 'capybara/rspec'

feature "Testando views tranferências" do

  # scenario "Operação Depósito válida?" do
  #   visit "/deposit"
  #   within "form" do
  #     find(".js-acc-dtn").set "1111"
  #     find(".js-dep-val").set "50"
  #   end
  #   click_button "Depositar"
  #   expect(page).to have_content "Depósito realizado."
  # end

  scenario "Operação Depósito inválida?" do
    page.visit "/deposit"
    page.within "form" do
      page.find(".js-acc-dtn").set ""
      page.find(".js-dep-val").set "50"
    end
    page.click_button "Depositar"
    expect(page).to have_content "Conta de destino não existe."
  end

  scenario "Operação Saque inválida sem conta?" do
    page.visit "/withdraw"
    page.within "form" do
      page.find(".js-acc-org").set "1111"
      page.find(".js-wit-val").set "50"
      page.find(".js-acc-pwd").set "87654321"
    end
    page.click_button "Sacar"
    expect(page).to have_content "Saque não realizado."
  end

  scenario "Operação Extrato válida?" do
    page.visit "/extract"
    page.within "form" do
      page.find(".js-acc-org").set "1111"
      page.find(".js-ini").set "01/03/2016"
      page.find(".js-fin").set "15/01/2016"
    end
    page.click_button "Solicitar"
    page.should have_content "Conta"
  end

  # scenario "Operação Tranferência" do
  #   visit "/transfer"
  #   within "form" do
  #     fill_in "transfer[origin_account]", :with => "1"
  #     fill_in "transfer[destiny_account]", :with => "2"
  #     fill_in "transfer[value]", :with => "20"
  #     fill_in "password", :with => "87654321"
  #   end
  #   click_button "Transferir"
  #   page.should have_content "Tranferência realizada."
  # end

  # scenario "Operação Extrato" do
  #   visit "/extract"
  #   within "form" do
  #     fill_in "account_id[0]", :with => "1"
  #     fill_in "data_ini", :with => "01/03/2016"
  #     fill_in "data_fin", :with => "10/03/2016"
  #   end
  #   click_button "Solicitar"
  #   page.should have_content "Extrato"
  # end

# end

feature "Testando views contas" do

  scenario "Operação Nova Conta" do
    page.visit "/accounts/new"
    page.within "form" do
      page.find(".js-acc-num").set "4321"
      page.find(".js-acc-bal").set "25"
      page.find(".js-acc-sts").set "Ativa"

    end
    click_button "Criar"
    page.should have_content "Conta criada."
  end
end

end
