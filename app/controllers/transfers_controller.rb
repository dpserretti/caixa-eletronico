class TransfersController < ApplicationController
  # before_action :set_account, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def deposit
  end

  def depositar
    @deposit = Transfer.new(deposit_params)
    valor = deposit_params[:value]
    @account = Account.find(deposit_params[:destiny_account])
    valor = valor.to_f
    @account.balance += valor
    @deposit.action = "Depósito"

    if @account.save
      if @deposit.save
        flash[:notice] = "Depósito realizado."
        redirect_to accounts_path
      end
    end
  end

  def withdraw
  end

  def sacar
    @withdraw = Transfer.new(withdraw_params)
    valor = deposit_params[:value]
    @account = Account.find(withdraw_params[:origin_account])
    valor = valor.to_f
    @account.balance -= valor

    @withdraw.action = "Saque"

    @user = User.find_by_email(current_user.email)

    if @user.valid_password?(params[:password])
      if @account.balance < 0
        redirect_to withdraw_path, :flash => { :error => "Saldo insuficiente." }
      else
        if @account.save
          if @withdraw.save
            flash[:notice] = "Saque realizado."
            redirect_to accounts_path
          end
        end
      end
    else
      redirect_to withdraw_path, :flash => { :error => "Saque não realizado. Senha incorreta." }
    end
  end

  def transfer
  end

  def transferir
    @transfer = Transfer.new(transfer_params)
    valor = deposit_params[:value]
    valor = valor.to_f
    @origin = Account.find(transfer_params[:origin_account])
    @destiny = Account.find(transfer_params[:destiny_account])
    @origin.balance -= valor
    @destiny.balance += valor
    @transfer.action = "Transferência"
    taxa = 0

    # verificar fluxo da taxa
    if valor > 1000
      taxa += 10
    else
      taxa += 5
    end

    agora = Time.now # retorna horário atual
    hoje = Date.today.wday # retorna inteiro da semana, 0 = Dom

    if hoje == 0 || hoje == 6
      taxa += 7
    else
      if agora.hour < 9 || agora.hour > 18
        taxa += 5
      else
        taxa += 7
      end
    end

    @origin.balance -= taxa

    @user = User.find_by_email(current_user.email)

    if @user.valid_password?(params[:password])
      if @origin.balance < 0
        redirect_to transfer_path , :flash => { :error => "Saldo insuficiente." }
      else
        if @transfer.save
          if @origin.save
            if @destiny.save
              flash[:notice] = "Transferência realizada."
              redirect_to accounts_path
            end
          end
        end
      end
    else
      redirect_to transfer_path , :flash => { :error => "Transferência não realizada. Senha incorreta." }
    end
  end

  def extract
  end

  def extrato
    data_ini = DateTime.parse(params[:data_ini])
    data_fin = DateTime.parse(params[:data_fin])
    data_ini = data_ini.beginning_of_day
    data_fin = data_fin.end_of_day
    @transfers = Transfer.where(:created_at => data_ini..data_fin, :user_id => current_user.id)
    # binding.pry
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
