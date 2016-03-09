require 'rails_helper'
require 'capybara/rspec'

context "Testando views tranferências" do
  # it "Nova conta" do
  #   visit deposit_path
  #   within("#new_transfer") do
  #     fill_in "transfer_destiny", :with => "4321"
  #     fill_in "transfer_value", :with => "25"
  #   end
  #   click_button "Depositar"
  #   expect(page).to have_content "Depósito realizado."
  # end

  # it "Operação Saque" do
  #   visit "/withdraw"
  #   within('form') do
  #     fill_in "transfer[origin_account]", :with => "10"
  #     fill_in "transfer[value]", :with => "250"
  #   end
  #   click_button "Sacar"
  #   expect(page).to have_content "Saque realizado."
  # end
end
