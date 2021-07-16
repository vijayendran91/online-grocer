class AdminController < ApplicationController
  def admin_home
    
  end

  def item_list
    @items = Item.all
    (0..@items.size-1).each do |i|
      @items[i][:itm_ctg] = Item::ITEM_CATAGORIES[@items[i][:itm_ctg].to_sym]
    end
    @new_item = Item.new
    @item_categories = Item::ITEM_CATAGORIES_LIST
  end

  def new_item
    params.require(:new_item).permit!
    @item = Item.new(params[:new_item])
    respond_to do |format|
      if @item.save
        format.html { redirect_to qwe_admin_item_list_path, notice: "Item was successfully created." }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end
end
