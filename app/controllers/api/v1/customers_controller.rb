class Api::V1::CustomersController < ApplicationController
  def index
    @customers = Customer.all
    render json: @customers
  end

  def show
    @customer = Customer.find(params[:id])
    render json: @customer
  end

  def create
    @customer = Customer.new(customer_param)
    if @customer.save
      render json: @customer, status: :created
    else
      render json: { error: @customer.error.messages }, status: :unprocessable_entity
    end
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_param)
      render json: @customer, status: :ok
    end
  end

  def destroy
    @customer = Customer.find(params[:id])
    if @customer.destroy
      render json: { message: 'Customer successfully deleted.' }, status: :ok
    else
      render json: { error: 'Failed to delete the customer.' }, status: :unprocessable_entity
    end
  end

  private

  def customer_param
    params.require(:customer).permit(:name, :address)
  end
end
