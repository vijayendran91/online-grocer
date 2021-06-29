class AdminController < ApplicationController
  def admin_home
    @is_admin_logged_in = is_admin_logged_in?
  end

  def item_list
    @items = Item.all
    @new_item = Item.new
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
