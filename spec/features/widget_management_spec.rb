require 'rails_helper'
require 'capybara/rspec'

feature "Testando views tranferências" do

  scenario "Operação Depósito" do
    visit "/deposit"
    within "form" do
      # find(".js-acc-id").set "1"
      find(".js-acc-dtn").set "1111"
      find(".js-dep-val").set "50"
    end
    click_button "Depositar"
    expect(page).to have_content "Depósito realizado."
  end

  # scenario "Operação Saque" do
  #   visit "/withdraw"
  #   within "form" do
  #     fill_in "transfer[origin_account]", :with => "1"
  #     fill_in "transfer[value]", :with => "50"
  #     fill_in "password", :with => "87654321"
  #   end
  #   click_button "Sacar"
  #   page.should have_content "Saque realizado."
  # end

  # scenario "Operação Saldo" do
  #   visit "/balance"
  #   within "form" do
  #     fill_in "account_id[0]", :with => "1"
  #   end
  #   click_button "Solicitar"
  #   page.should have_content "Saldo"
  # end

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

# feature "Testando views contas" do

#   scenario "Operação Nova Conta" do
#     visit "/accounts/new"
#     within "form" do
#       fill_in "account[number]", :with => "4321"
#       fill_in "account[balance]", :with => "25"
#       fill_in "account[status]", :with => "Ativa"
#     end
#     click_button "Criar"
#     page.should have_content "Conta criada."
#   end

end
