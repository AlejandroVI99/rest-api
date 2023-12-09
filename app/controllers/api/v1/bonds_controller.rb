class Api::V1::BondsController < ApplicationController
  before_action :authenticate_user!

  def index
    @bonds = Bond.all
    render json: @bonds
  end

  def show
    @bond = Bond.find(params[:id])
    if @bond
      render json: @bond
    else
      render json: @bond, status: :unprocessable_entity
    end
  end

  def create
    @bond = Bond.new(bond_params)
    @bond.validate_name
    @bond.validate_quantity
    @bond.validate_selling_price
    if @bond.save
      render json: @bond
    else
      render json: { status: 422, errors: bond.errors.full_messages }
    end
  end

  def destroy
    @bond = Bond.find(params[:id])
    @bond.destroy
    render json: @bond, status: :destroyed
  end

  def update
    @bond = Bond.find(params[:id])
    if @bond.update(bond_params)
      render json: @bond
    else
      render json: @bond, status: :unprocessable_entity
    end
  end

  def user_bonds
    @bonds = Bond.where(user_id: current_user.id)
    if @bonds
      render json: @bonds
    else
      render json: @bonds, status: :unprocessable_entity
    end
  end

  def bonds_for_buy
    @bonds = Bond.where.not(user_id: current_user.id)
    if @bonds
      render json: @bonds
    else
      render json: @bonds, status: :unprocessable_entity
    end
  end

  def buy_bonds
    @bond = Bond.find(params[:id])
    @bond.buy_bond
    render json: @bond
  end

  private

  def bond_params
    params.require(:bond).permit(:name, :quantity, :selling_price)
  end
end
