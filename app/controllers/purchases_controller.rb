class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_purchase, only: %i[show edit update destroy]

  # GET /purchases or /purchases.json
  def index
    @purchases = Purchase.all
  end

  # GET /purchases/1 or /purchases/1.json
  def show; end

  # GET /purchases/new
  def new
    @attributes = []

    # Create a new Purchase object and add it to the attributes array
    @purchase = Purchase.new
    @attributes << @purchase

    # Retrieve the categories associated with the current user and add them to the attributes array
    @categories = current_user.categories
    @attributes << @categories
  end

  # GET /purchases/1/edit
  def edit
    @attributes = []
    @attributes << @purchase
    @categories = current_user.categories
    @attributes << @categories
  end

  # POST /purchases
  def create
    @attributes = []
    @purchase = Purchase.new(purchase_params)
    @purchase.author = current_user
    category_id = params[:purchase][:category_id]
    if category_id.present?
      category = Category.find(category_id)
      @purchase.categories << category
    end
    @attributes << @purchase
    @categories = current_user.categories
    @attributes << @categories

    if @purchase.save
      redirect_to category_url(@purchase.categories[0]), notice: 'Purchase was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /purchases/1
  def update
    if @purchase.update(purchase_params)
      redirect_to purchase_url(@purchase), notice: 'Purchase was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /purchases/1
  def destroy
    if @purchase.destroy
      redirect_to categories_url, notice: 'Purchase was successfully destroyed.'
    else
      redirect_to categories_url, alert: 'Failed to destroy the purchase.'
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_purchase
    @purchase = Purchase.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def purchase_params
    params.require(:purchase).permit(:name, :amount)
  end
end
