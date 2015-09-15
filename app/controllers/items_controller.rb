class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :check_admin, only: [:new, :edit, :create, :update, :destroy]


  def index
    if params.has_key?(:categories)
      #category_name = params[:categories]
      getItemsInCategory(params[:categories])
    elsif params.has_key?(:search)
      getSearchedItems(params[:search])
    else
      @items = Item.all
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
      redirect_to items_url, notice: 'Item was successfully destroyed.'
      #head :no_content
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:price, :photo, :name, :currency, :description, :quantity_unit, :category_ids => [])
    end

    def check_admin
      unless current_customer.try(:admin?)
        flash[:notice] = 'You are not allowed to do this!'
        redirect_to(items_url)
      end
    end

    def getItemsInCategory(category)
      @items = Item.all
      @new_items = Array.new
      @items.each do |i|
        i.categories.each do |c|
          if c.name == category
            @new_items.append(i)
          end
        end
      end
      @items = @new_items
    end

    def getSearchedItems(search)
      search = search.downcase
      @items = Item.all
      @new_items = Array.new
      @items.each do |i|
        if i.name.downcase.include?(search)
          @new_items.append(i)
        end
      end
      if @new_items.any?
        @items = @new_items
        flash.now[:notice] = 'Your search was successful'
      else
        flash.now[:error] = 'No items found that satisfy the search!'
      end
    end
