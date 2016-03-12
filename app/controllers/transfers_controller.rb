class TransfersController < ApplicationController
  before_action :authenticate_user!

  def deposit
  end

  def depositar
    deposit = Transfer.new(deposit_params)
    valor = deposit_params[:value]
    @account = Account.where(:number => deposit_params[:destiny_account])
    account = @account[0]

    if account.nil?
      redirect_to deposit_path , :flash => { :error => "Depósito não realizado. Conta de destino não existe." }
    else
      if account.status == "Encerrada"
        redirect_to deposit_path , :flash => { :error => "Depósito não realizado. Conta de destino foi encerrada." }
      else
        valor = valor.gsub(',', '.').to_f
        account.balance += valor
        deposit.value = valor
        deposit.destiny_acc_number = account.number
        deposit.destiny_account = account.id
        deposit.action = "Depósito"
        deposit.tax = 0

        if account.save
          if deposit.save
            flash[:notice] = "Depósito realizado."
            redirect_to accounts_path
          end
        end
      end
    end
  end

  def withdraw
  end

  def sacar
    withdraw = Transfer.new(withdraw_params)
    valor = withdraw_params[:value]
    account = Account.find(withdraw_params[:origin_account])
    user = User.find_by_email(current_user.email)

    if user.valid_password?(params[:password])
      if account.balance < 0
        redirect_to withdraw_path, :flash => { :error => "Saque não realizado. Saldo insuficiente." }
      else
        valor = valor.gsub(',', '.').to_f
        account.balance -= valor
        withdraw.value = valor
        withdraw.origin_acc_number = account.number
        withdraw.action = "Saque"
        withdraw.tax = 0
        if account.save
          if withdraw.save
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
    transfer = Transfer.new(transfer_params)
    valor = transfer_params[:value]
    valor = valor.gsub(',', '.').to_f
    origin = Account.find(transfer_params[:origin_account])
    @destiny = Account.where(:number => transfer_params[:destiny_account])
    destiny = @destiny[0]

    if destiny.nil?
      redirect_to transfer_path , :flash => { :error => "Tranferência não realizada. Conta de destino não existe." }
    else
      if destiny.status == "Encerrada"
        redirect_to transfer_path , :flash => { :error => "Tranferência não realizada. Conta de destino foi encerrada." }
      else
        agora = Time.now
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

        valor = valor.to_f
        if valor > 1000
          taxa += 10
        end

        user = User.find_by_email(current_user.email)
        origin.balance -= valor
        destiny.balance += valor
        origin.balance -= taxa
        transfer.value = valor
        transfer.tax = taxa

        if user.valid_password?(params[:password])
          if origin.balance < 0
            redirect_to transfer_path , :flash => { :error => "Saldo insuficiente." }
          else
            transfer.origin_account = origin.id
            transfer.origin_acc_number = origin.number
            transfer.destiny_account = destiny.id
            transfer.destiny_acc_number = destiny.number
            transfer.action = "Transferência"
            if transfer.save
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
    end
  end

  def extract
  end

  def extrato
    data_ini = DateTime.parse(params[:data_ini])
    data_fin = DateTime.parse(params[:data_fin])
    data_ini = data_ini.beginning_of_day
    data_fin = data_fin.end_of_day
    # binding.pry
    conta = params[:account_id]
    transfers1 = Transfer.where(:created_at => data_ini..data_fin, :origin_account => conta["0"], :user_id => current_user.id)
    transfers2 = Transfer.where(:created_at => data_ini..data_fin, :destiny_account => conta["0"], :user_id => current_user.id)
    transfs = transfers1 + transfers2
    @conta = Account.find(conta["0"])
    @extratos = transfs.sort_by(&:created_at)
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
