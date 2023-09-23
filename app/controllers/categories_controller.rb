class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: %i[show edit update destroy]

  # GET /categories
  # retrieves a list of categories belonging to the user and associated purchases
  def index
    @categories = current_user.categories.includes(:purchases)
  end

  # GET /categories/1
  # retrieves a specific category based on the :id parameter then fetches the associated purchases
  def show
    @purchases = @category.purchases.order(created_at: :desc)
  end

  # GET /categories/new
  # build the form for creating a new category.
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit; end

  # POST /categories
  def create
    @category = Category.new(category_params)
    @category.user = current_user # sets the user association to the currently authenticated user

    # save the category
    if @category.save
      handle_uploaded_icon_file if category_params[:icon].present?
      redirect_to categories_path, notice: 'Category was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /categories/1
  def update
    if @category.update(category_params)
      handle_uploaded_icon_file if category_params[:icon].present?
      redirect_to category_url(@category), notice: 'Category was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /categories/1
  def destroy
    @category.destroy
    redirect_to categories_url, notice: 'Category was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = Category.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def category_params
    params.require(:category).permit(:name, :icon)
  end

  def handle_uploaded_icon_file
    uploaded_file = category_params[:icon]
    file_path = Rails.root.join('public', 'icon_uploads', uploaded_file.original_filename)

    File.binwrite(file_path, uploaded_file.read)

    @category.update(icon: File.join('/icon_uploads', uploaded_file.original_filename))
  end
end
