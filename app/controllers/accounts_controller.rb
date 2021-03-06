class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /accounts
  # GET /accounts.json
  def index
    @accounts = Account.where(:user_id => current_user.id)
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
  end

  # GET /accounts/new
  def new
    @account = Account.new
  end

  # GET /accounts/1/edit
  def edit
    if current_user.id != @account.user_id
      redirect_to accounts_path, :flash => { :error => "Esta conta não pertence a você." }
    else
      @account = Account.find(params[:id])
      if @account.status == "Encerrada"
        redirect_to accounts_path, :flash => { :error => "Você não pode editar um conta encerrada." }
      end
    end
  end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = Account.new(account_params)
    valor = account_params[:balance]
    valor = valor.gsub('R$ ', '')
    valor = valor.gsub('.', '')
    valor = valor.gsub(',', '.').to_f
    @account.balance = valor
    respond_to do |format|
      if @account.save
        format.html { redirect_to @account, notice: 'Conta criada.' }
        format.json { render :show, status: :created, location: @account }
      else
        format.html { render :new }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to @account, notice: 'Conta atualizada.' }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    # @account.destroy
    @account.update_attribute(:status, "Encerrada")
    respond_to do |format|
      format.html { redirect_to accounts_url, notice: 'Conta encerrada.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      params.require(:account).permit(:user_id, :number, :balance, :status)
    end

end
