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
    @deposit.new_balance = @account.balance
    @deposit.destiny_acc_number = @account.number
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
    @withdraw.new_balance = @account.balance
    @withdraw.origin_acc_number = @account.number
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
    origin = Account.find(transfer_params[:origin_account])
    @destiny = Account.where(:number => transfer_params[:destiny_account])
    destiny = @destiny[0]

    if destiny.nil?
      redirect_to transfer_path , :flash => { :error => "Conta de destino não existe." }
    end

    agora = Time.now # retorna horário atual
    hoje = Date.today.wday # retorna inteiro da semana, 0 = Dom
    taxa = 0

    if agora.hour >= 9 && agora.hour <= 18
      if hoje == 0 || hoje == 6
        taxa = 7
      else
        taxa = 5
      end
    else
      taxa = 7
    end

    if valor > 1000
      taxa += 10
    end

    @user = User.find_by_email(current_user.email)

    if @user.valid_password?(params[:password])
      if origin.balance < 0
        redirect_to transfer_path , :flash => { :error => "Saldo insuficiente." }
      else
        origin.balance -= valor
        destiny.balance += valor
        origin.balance -= taxa
        @transfer.new_balance = origin.balance
        @transfer.origin_acc_number = origin.number
        @transfer.destiny_acc_number = destiny.number
        @transfer.destiny_account = destiny.id
        # @transfer.tax = taxa
        @transfer.action = "Transferência"
        if @transfer.save
          if origin.save
            if destiny.save
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
    conta = params[:account_id]
    @conta = Account.find(conta["0"])
    @saldo_ini = Account.where(:id => conta["0"], :updated_at => data_ini)
    @saldo_fin = Account.where(:id => conta["0"], :updated_at => data_fin)
    # pegar obj conta para mostrar saldo inicial e final do periodo
    transfers1 = Transfer.where(:created_at => data_ini..data_fin, :origin_account => conta["0"], :user_id => current_user.id)
    transfers2 = Transfer.where(:created_at => data_ini..data_fin, :destiny_account => conta["0"], :user_id => current_user.id)
    transfs = transfers1 + transfers2
    @tudo = transfs.sort_by(&:created_at)
    # adicionar campo taxa e colocar campo de deposito livre e conta destino
    # na transferência também
    binding.pry
  end

  def balance
  end

  def saldo
    conta = params[:account_id]
    @conta = Account.find(conta["0"])
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
