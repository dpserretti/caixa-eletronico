class TransfersController < ApplicationController
  # before_action :set_account, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def deposit
  end

  def withdraw
  end

  def transfer
  end

  def depositar
    @deposit = Transfer.new(deposit_params)
    valor = deposit_params[:value]
    @account = Account.find(deposit_params[:destiny_account])
    valor = valor.to_f
    @account.balance += valor

    if @account.save
      if @deposit.save
        flash[:notice] = "Depósito realizado."
        redirect_to accounts_path
      end
    end
  end

  def sacar
    @withdraw = Transfer.new(withdraw_params)
    valor = deposit_params[:value]
    @account = Account.find(withdraw_params[:origin_account])
    valor = valor.to_f
    @account.balance -= valor

    if @account.balance < 0
      flash[:notice] = "Saldo insuficiente."
      # redirect_to accounts_path
    end

    if @account.save
      if @withdraw.save
        flash[:notice] = "Saque realizado."
        redirect_to accounts_path
      end
    end
  end

  def transferir
    @transfer = Transfer.new(transfer_params)
    valor = deposit_params[:value]
    valor = valor.to_f
    @origin = Account.find(transfer_params[:origin_account])
    @destiny = Account.find(transfer_params[:destiny_account])
    @origin.balance -= valor
    @destiny.balance += valor

    if @origin.balance < 0
      flash[:notice] = "Saldo insuficiente."
      # redirect_to accounts_path
    end

    if @transfer.save
      if @origin.save
        if @destiny.save
          flash[:notice] = "Saque realizado."
          redirect_to accounts_path
        end
      end
    end
  end

  def deposit_params
    params.require(:transfer).permit(:user_id, :destiny_account, :value)
  end

  def withdraw_params
    params.require(:transfer).permit(:user_id, :origin_account, :value)
  end

  def transfer_params
    params.require(:transfer).permit(:user_id, :origin_account, :destiny_account, :value)
  end

end
