class PaymentsController < ApplicationController
  before_action :redirect_to_splash, unless: :signed_in?
  load_and_authorize_resource
  before_action :set_payment, only: %i[show edit update destroy]

  # GET /payments or /payments.json
  def index
    @payments = Payment.all
  end

  # GET /payments/1 or /payments/1.json
  def show; end

  # GET /payments/new
  def new
    @group = Group.find(params[:group_id])
    @payment = Payment.new
    @groups = Group.where(user_id: current_user.id)
  end

  # GET /payments/1/edit
  def edit; end

  # POST /payments or /payments.json
  def create
    @payment = Payment.new(payment_params)
    @payment.user = current_user
    @group = Group.find(params[:group_id])
    if params[:grp_ids]
      params[:grp_ids].each do |group_id|
        group = Group.find(group_id)
        group.payments << @payment
      end
    else
      redirect_to new_group_payment_path(@group), flash: { alert: 'You must select at least one category.' }
      return
    end

    respond_to do |format|
      if @payment.save
        format.html { redirect_to group_path(@group), notice: 'Payment was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payments/1 or /payments/1.json
  def update
    respond_to do |format|
      if @payment.update(payment_params)
        format.html { redirect_to payment_url(@payment), notice: 'Payment was successfully updated.' }
        format.json { render :show, status: :ok, location: @payment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1 or /payments/1.json
  def destroy
    @payment.destroy
    @group = Group.find(params[:group_id])

    respond_to do |format|
      format.html { redirect_to group_url(@group), notice: 'Payment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_payment
    @payment = Payment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def payment_params
    params.require(:payment).permit(:name, :amount)
  end
end
